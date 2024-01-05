//
//  Adapter.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import Foundation

struct Adapter {
    func getTask(_ events: [EventModel]) -> [TaskModel] {
        return events.map { TaskModel($0) }
    }

    func getEvents(_ tasks: [TaskModel]) -> [EventModel] {
        return tasks.map { EventModel($0) }
    }
}
