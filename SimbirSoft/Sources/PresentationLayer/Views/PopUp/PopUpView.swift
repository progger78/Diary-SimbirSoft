//
//  PopUpView.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 03.01.2024.
//

import UIKit
import SnapKit

final class PopUpView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    private lazy var taskTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .systemBackground
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    private lazy var startDateTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .systemBackground
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var finishDateTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .systemBackground
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private lazy var taskDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20.0, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private(set) lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
        button.backgroundColor = Resources.Colors.active
        button.layer.cornerRadius = 18
        button.setTitle("Ok", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PopUpView {
    private func initialize() {
        backgroundColor = .black.withAlphaComponent(0.3)
        contentView.addSubviews(taskTitle, startDateTitle, finishDateTitle, taskDescription, button)
        addSubview(contentView)
        layoutViews()
    }
    func configureView(taskTitle: String, startDate: String, finishDate: String, text: String) {
        self.taskTitle.text = taskTitle
        startDateTitle.text = "Дата начала дела:\n\(startDate)"
        finishDateTitle.text = "Дата окончания дела:\n\(finishDate)"
        taskDescription.text = "Описание дела:\n\(text)"
    }
    func layoutViews() {
        let standartInset = 16
        contentView.snp.makeConstraints {
            $0.width.equalTo(340)
            $0.centerX.equalTo(snp.centerX)
            $0.centerY.equalTo(snp.centerY)
        }
        taskTitle.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(standartInset)
        }
        startDateTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(standartInset)
            $0.top.equalTo(taskTitle.snp.bottom).inset(-15)
        }
        finishDateTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(standartInset)
            $0.top.equalTo(startDateTitle.snp.bottom).inset(-10)
        }
        taskDescription.snp.makeConstraints {
            $0.top.equalTo(finishDateTitle.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(standartInset)
        }
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(taskDescription.snp.bottom).inset(-20)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
}
