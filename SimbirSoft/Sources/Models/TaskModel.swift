//
//  TaskModel.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import Foundation

struct TaskModel: Codable {
    let id: Int
    let dateStart: TimeInterval
    let dateFinish: TimeInterval
    let name: String
    let description: String

    private enum CodingKeys: String, CodingKey {
        case id
        case dateStart = "date_start"
        case dateFinish = "date_finish"
        case name
        case description
    }

    init(_ event: EventModel) {
        self.id = event.id
        self.dateStart = event.dateInterval.start.timeIntervalSince1970
        self.dateFinish = event.dateInterval.end.timeIntervalSince1970
        self.name = event.text
        self.description = event.description
    }
}
