//
//  Resources.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 03.01.2024.
//

import UIKit

enum Constants {

    enum Colors {
        static let active: UIColor = .link
        static let inactive: UIColor = .lightGray
        static let red: UIColor = .red
    }
    enum Strings {
        enum AddTask {
            static let nameLabel = "Наименование:"
            static let descriptionLabel = "Описанине:"
            static let namePlaceholder = "Назовите задачу"
            static let descriptionPlaceholder = "Опишите, что нужно сделать"
            static let startDate = "Время старта"
            static let finishDate = "Время окончания"
            static let addTaskButton = "Добавить задачу"
        }
    }
    enum Images {
        enum Common {
            static let addButton = UIImage(systemName: "plus")
        }
    }

}
