//
//  JsonHandler.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import Foundation

protocol JsonHandlerProtocol: AnyObject {
    func loadTaskData(_ completion: @escaping (Result<[TaskModel]?, Error>) -> Void)
    func saveTasksData(_ tasks: [TaskModel], completion: @escaping (Error?) -> Void)
}

final class JsonHandler: JsonHandlerProtocol {
    private lazy var decoder = JSONDecoder()
    private lazy var encoder = JSONEncoder()

    func loadTaskData(_ completion: @escaping (Result<[TaskModel]?, Error>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            do {
                let url = try URL.tasksDirectory()

                // Проверяем наличие файла по указанному URL
                if FileManager.default.fileExists(atPath: url.path) {
                    let data = try Data(contentsOf: url)
                    let tasks = try self?.decoder.decode([TaskModel].self, from: data)
                    completion(.success(tasks))
                } else {
                    // Файл отсутствует, возвращаем пустой результат
                    completion(.success(nil))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    func saveTasksData(_ tasks: [TaskModel], completion: @escaping (Error?) -> Void) {
        DispatchQueue.global().async { [weak self] in
            do {
                let directoryURL = try URL.tasksDirectory()
                let data = try self?.encoder.encode(tasks)
                try data?.write(to: directoryURL)
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
}
