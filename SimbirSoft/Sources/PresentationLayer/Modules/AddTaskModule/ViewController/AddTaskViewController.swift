//
//  AddTaskViewController.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import UIKit
import SnapKit

final class AddTaskViewController: UIViewController {

    private let dataProvider: DataProviderProtocol

    private lazy var addTaskView: AddTaskView = {
        let view = AddTaskView()
        view.delegate = self
        return view
    }()

    private lazy var dismissKeyboardGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissKeyboard)
    )

    init(
        provider: DataProviderProtocol = DataProvider.shared
    ) {
        self.dataProvider = provider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = addTaskView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

extension AddTaskViewController: AddTaskViewDelegate {
    func userCreateEvent(with model: EventModel) {
        dataProvider.events += [model]
        navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: .updateUserEvents, object: nil)
    }
}

private extension AddTaskViewController {
    func initialize() {
        configureView()
    }

    func configureView() {
        navigationController?.navigationBar.tintColor = .black
        view.addGestureRecognizer(dismissKeyboardGesture)
    }
}

private extension AddTaskViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
