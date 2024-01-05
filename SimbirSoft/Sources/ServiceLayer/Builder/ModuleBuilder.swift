//
//  CalendarModuleBuilder.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func buildCalendarScene() -> UIViewController
    static func buildAddTaskScene() -> UIViewController
}

enum ModuleBuilder: ModuleBuilderProtocol {
    static func buildCalendarScene() -> UIViewController {
        let viewModel: CalendarViewModelProtocol = CalendarViewModel()
        let viewController = CalendarViewController(viewModel: viewModel)
        return viewController
    }
    static func buildAddTaskScene() -> UIViewController {
        let viewController = AddTaskViewController()
        return viewController
    }
}
