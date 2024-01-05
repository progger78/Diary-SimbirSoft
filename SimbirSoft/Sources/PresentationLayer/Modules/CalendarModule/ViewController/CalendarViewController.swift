//
//  CalendarViewController.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import UIKit
import CalendarKit

private enum Constants {

    static let titleText = "Simbirsoft"
}

final class CalendarViewController: DayViewController {

    private let viewModel: CalendarViewModelProtocol

    private lazy var barButton = UIBarButtonItem(
        barButtonSystemItem: .add,
        target: self,
        action: #selector(addTask)
    )

    init(viewModel: CalendarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
}

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        readyToDisplayError()
        readyToUpdateForNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }

    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return viewModel.getUserEvents()
    }

    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let eventModel = eventView.descriptor as? EventModel else { return }
        presentEventDetailView(eventModel)
    }
}

// MARK: - UI

private extension CalendarViewController {
    func initialSetup() {
        title = Constants.titleText
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = barButton
    }
}

// MARK: - Actions

private extension CalendarViewController {
    @objc func addTask() {
        let module = ModuleBuilder.buildAddTaskScene()
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(module, animated: true)
    }

    func presentEventDetailView(_ event: EventModel) {
        let popUpWindow = PopUpWindow(
            taskTitle: event.text,
            startDate: event.dateInterval.start.dateToString(),
            finishDate: event.dateInterval.end.dateToString(),
            text: event.description
        )
        present(popUpWindow, animated: true)
    }

    @objc func updateEvents() {
        reloadData()
    }
}

private extension CalendarViewController {
    func readyToDisplayError() {
        viewModel.errorCallback = { [weak self] in
            self?.showAlert(with: $0.localizedDescription)
        }
    }

    func readyToUpdateForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateEvents),
            name: .updateUserEvents,
            object: nil
        )
    }
}
