//
//  EventModel.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import CalendarKit
import UIKit

final class EventModel: EventDescriptor {

    var color: UIColor
    var editedEvent: CalendarKit.EventDescriptor?
    var dateInterval = DateInterval()
    var isAllDay = false
    var text = ""
    var description = ""
    var id: Int = 0
    var attributedText: NSAttributedString?
    var lineBreakMode: NSLineBreakMode?
    var backgroundColor = SystemColors.systemBlue.withAlphaComponent(0.3)
    var textColor = SystemColors.label
    var font = UIFont.boldSystemFont(ofSize: 12)
    var userInfo: Any?

    init(
        id: Int,
        text: String,
        dateInterval: DateInterval,
        description: String,
        color: UIColor = .white
    ) {
        self.dateInterval = dateInterval
        self.text = text
        self.description = description
        self.id = id
        self.color = color
    }

    init(_ task: TaskModel) {
        self.text = task.name
        self.description = task.description
        self.id = task.id
        self.color = .white
        self.dateInterval = DateInterval(
            start: Date(timeIntervalSince1970: task.dateStart),
            end: Date(timeIntervalSince1970: task.dateFinish)
        )
    }

    func makeEditable() -> EventModel {
        return EventModel(
            id: id,
            text: text,
            dateInterval: dateInterval,
            description: description
        )
    }

    func commitEditing() {
        guard let edited = editedEvent else {return}
        edited.dateInterval = dateInterval
    }
}
