//
//  CreateTaskUseCase.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import Foundation

struct CreateTaskUseCase {
    func execute(title: String) -> Task {
        return Task(id: UUID(), title: title, isDone: false)
    }
}
