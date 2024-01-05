//
//  AddTaskView.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import UIKit
import SnapKit

protocol AddTaskViewDelegate: AnyObject {
    func userCreateEvent(with model: EventModel)
}

final class AddTaskView: UIView {

    // MARK: - Property

    weak var delegate: AddTaskViewDelegate?

    // MARK: - UI

    private lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.AddTask.nameLabel
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.AddTask.descriptionLabel
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()

    private lazy var startLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.AddTask.startDate
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()

    private lazy var finishLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.AddTask.finishDate
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        return label
    }()

    private lazy var nameTextField: UITextField = {
        let textField = TextFieldWithPadding()
        textField.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        textField.placeholder = Resources.Strings.AddTask.namePlaceholder
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.delegate = self
        return textField
    }()

    private lazy var descriptionTextField: UITextField = {
        let textField = TextFieldWithPadding()
        textField.textPadding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        textField.placeholder = Resources.Strings.AddTask.descriptionPlaceholder
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.delegate = self
        return textField
    }()

    private lazy var startDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        let loc = Locale(identifier: "ru")
        datePicker.locale = loc
        return datePicker
    }()

    private lazy var finishDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        let loc = Locale(identifier: "ru")
        datePicker.locale = loc
        return datePicker
    }()

    private lazy var addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        button.backgroundColor = Resources.Colors.inactive
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.setImage(Resources.Images.Common.addButton, for: .normal)
        button.tintColor = .white
        button.setTitle(Resources.Strings.AddTask.addTaskButton, for: .normal)
        button.isEnabled = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddTaskView {
    func initialize() {
        setUpView()
        layoutViews()
        configuteConstraints()
    }
    func setUpView() {
        backgroundColor = .systemBackground
    }
    func layoutViews() {
        addSubviews(
            taskNameLabel,
            descriptionLabel,
            startLabel,
            finishLabel,
            nameTextField,
            descriptionTextField,
            addTaskButton,
            startDatePicker,
            finishDatePicker
        )
    }

    func configuteConstraints() {
        let standartInset = 16

        taskNameLabel.snp.makeConstraints {
            $0.top.equalTo(layoutMarginsGuide.snp.top)
            $0.leading.equalToSuperview().inset(standartInset)
        }
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(taskNameLabel.snp.bottom).inset(-10)
            $0.height.equalTo(60)
            $0.leading.trailing.equalToSuperview().inset(standartInset)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(standartInset)
        }
        descriptionTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).inset(-10)
            $0.height.equalTo(60)
            $0.leading.right.equalToSuperview().inset(standartInset)
        }
        startLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTextField.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(standartInset)
        }
        startDatePicker.snp.makeConstraints {
            $0.top.equalTo(startLabel.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(standartInset)
        }
        finishLabel.snp.makeConstraints {
            $0.top.equalTo(startDatePicker.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(standartInset)
        }
        finishDatePicker.snp.makeConstraints {
            $0.top.equalTo(finishLabel.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(standartInset)
        }
        addTaskButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.trailing.leading.equalToSuperview().inset(standartInset)
            $0.height.equalTo(40)
        }
    }

    @objc func addTaskButtonTapped() {
        if let preparedModel = prepareEventModel() {
            delegate?.userCreateEvent(with: preparedModel)
        }
    }
}

// MARK: - Helpers

private extension AddTaskView {
    func prepareEventModel() -> EventModel? {
        guard
            let eventName = nameTextField.text, eventName != "",
            let descriptionText = descriptionTextField.text
        else {
            return nil
        }

        let id = IDCreator.shared.createUniqueID()
        let startEvent = startDatePicker.date
        let finishEvent = finishDatePicker.date

        return EventModel(
            id: id,
            text: eventName,
            dateInterval: .init(start: startEvent, end: finishEvent),
            description: descriptionText
        )
    }
}

// MARK: - UITextFieldDelegate

extension AddTaskView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let nameText = nameTextField.text, let descriptionText = descriptionTextField.text else { return }
        switch (!nameText.isEmpty, !descriptionText.isEmpty) {
        case (true, true):
            addTaskButton.isEnabled = true
            addTaskButton.backgroundColor = Resources.Colors.active
        default:
            addTaskButton.isEnabled = false
            addTaskButton.backgroundColor = Resources.Colors.inactive
        }
    }
}
