//
//  CreateTaskUseCase.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import Foundation

struct CreateTaskUseCase {
    func execute(title: String) -> Result<Task, CreateTaskError> {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let error = TaskTitleValidator.validate(trimmed) {
            return .failure(error)
        }
        
        return .success(Task(id: UUID(), title: trimmed, isDone: false))

    }
}
