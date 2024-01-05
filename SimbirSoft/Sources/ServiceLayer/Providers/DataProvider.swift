//
//  DataProvider.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import Foundation

protocol DataProviderErrorDelegate: AnyObject {
    func showErrorAlert(with message: Error)
}

protocol DataProviderProtocol: AnyObject {
    var events: [EventModel] { get set }
    var delegate: DataProviderErrorDelegate? { get set }
    func loadTasks(completion: @escaping (Result<[TaskModel], Error>) -> Void)
    func saveTasks(_ tasks: [TaskModel], completion: @escaping (Error?) -> Void)
}

final class DataProvider: DataProviderProtocol {
    static let shared: DataProviderProtocol = DataProvider()

    weak var delegate: DataProviderErrorDelegate?

    var events: [EventModel] {
        get {
            threadSafeQueue.sync { [weak self] in
                guard let self else { return [] }
                return self.adapter.getEvents(tasks)
            }
        }
        set {
            threadSafeQueue.async(flags: .barrier) { [weak self] in
                guard let self else { return }
                self.tasks = self.adapter.getTask(newValue)
            }
        }
    }

    private let adapter: Adapter
    private let jsonHandler: JsonHandlerProtocol

    private let threadSafeQueue = DispatchQueue(label: "com.simbirsoft.threadSafeQueue", attributes: .concurrent)

    private var storedTasks: [TaskModel] = []
    private var tasks: [TaskModel] {
        get { return storedTasks }
        set {
            storedTasks = newValue
            saveTasks(newValue) { [weak self] error in
                guard let error else { return }
                self?.delegate?.showErrorAlert(with: error)
            }
        }
    }

    private init(
        adapter: Adapter = .init(),
        jsonHandler: JsonHandlerProtocol = JsonHandler()
    ) {
        self.adapter = adapter
        self.jsonHandler = jsonHandler
        self.fetchEvents()
    }

    func loadTasks(completion: @escaping (Result<[TaskModel], Error>) -> Void) {
        jsonHandler.loadTaskData { result in
            switch result {
            case .success(let tasksData):
                guard let tasksData else { return }
                completion(.success(tasksData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func saveTasks(_ tasks: [TaskModel], completion: @escaping (Error?) -> Void) {
        jsonHandler.saveTasksData(tasks) { completion($0) }
    }

    private func fetchEvents() {
        loadTasks { [weak self] result in
            switch result {
            case .success(let loadedTasks):
                self?.tasks = loadedTasks
            case .failure(let error):
                self?.delegate?.showErrorAlert(with: error)
            }
        }
    }
}
