//
//  CreateTaskUseCase.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import Foundation

struct CreateTaskUseCase {
    func execute(title: String) -> Result<Task, CreateTaskError> {
        if let error = TaskTitleValidator.validate(title) {
            return .failure(error)
        }

        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let task = Task(id: UUID(), title: trimmed, isDone: false)
        return .success(task)
    }
}
