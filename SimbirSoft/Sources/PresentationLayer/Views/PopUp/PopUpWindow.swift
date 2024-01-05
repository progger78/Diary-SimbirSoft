//
//  PopUpView.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 03.01.2024.
//

import Foundation
import UIKit

final class PopUpWindow: UIViewController {

    private let popUpView = PopUpView()

    init(
        taskTitle: String,
        startDate: String,
        finishDate: String,
        text: String
    ) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen

        popUpView.configureView(taskTitle: taskTitle, startDate: startDate, finishDate: finishDate, text: text)
        popUpView.button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view = popUpView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
}
