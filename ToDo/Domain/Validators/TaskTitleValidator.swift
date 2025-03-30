//
//  TaskTitleValidator.swift
//  ToDo
//
//  Created by Jean Camargo on 30/03/25.
//

import Foundation

enum TaskTitleValidator {
    static func validate(_ rawTitle: String) -> CreateTaskError? {
        let trimmed = rawTitle.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            return .emptyTitle
        }

        guard trimmed.count <= 100 else {
            return .tooLong
        }

        return nil
    }
}

