//
//  IDCreator.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import Foundation

protocol IDCreatorProtocol: AnyObject {
    /// Allows to get a unique id for a task
    func createUniqueID() -> Int
}

final class IDCreator: IDCreatorProtocol {

    // MARK: - Property

    static let shared: IDCreatorProtocol = IDCreator()

    private var id: Int {
        get { UserDefaults.standard.integer(forKey: "uniqueIdentifier") }
        set { UserDefaults.standard.set(newValue, forKey: "uniqueIdentifier") }
    }

    // MARK: - Initialization

    private init() {}

    // MARK: - Public

    func createUniqueID() -> Int {
        return Int(UUID().hashValue)
    }
}
