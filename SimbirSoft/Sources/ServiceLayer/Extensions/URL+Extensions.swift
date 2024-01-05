//
//  URL+Extensions.swift
//  SimbirSoft
//
//  Created by Егор Павлов on 02.01.2024.
//

import Foundation

extension URL {
    static func tasksDirectory(for fileName: String = "tasks.json") throws -> URL {
        let applicationSupport = try FileManager.default.url(
            for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let subDirectory = applicationSupport.appendingPathComponent(bundleID, isDirectory: true)
        try FileManager.default.createDirectory(at: subDirectory, withIntermediateDirectories: true, attributes: nil)
        let taskURL = subDirectory.appendingPathComponent(fileName)
        return taskURL
    }
}
