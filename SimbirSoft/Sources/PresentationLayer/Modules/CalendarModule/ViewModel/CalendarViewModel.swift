//
//  CalendarViewModel.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import Foundation

protocol CalendarViewModelProtocol: AnyObject {
    var errorCallback: ((Error) -> Void)? { get set }
    func updateUserEvents()
    func getUserEvents() -> [EventModel]
}

final class CalendarViewModel: CalendarViewModelProtocol {

    var errorCallback: ((Error) -> Void)?

    private let provider: DataProviderProtocol
    private var events: [EventModel] = []

    init(
        dataProvider: DataProviderProtocol = DataProvider.shared
    ) {
        self.provider = dataProvider
        self.provider.delegate = self
    }

    func updateUserEvents() {
        events = provider.events
    }

    func getUserEvents() -> [EventModel] {
        events = provider.events
        return events
    }
}

extension CalendarViewModel: DataProviderErrorDelegate {
    func showErrorAlert(with message: Error) {
        errorCallback?(message)
    }
}
