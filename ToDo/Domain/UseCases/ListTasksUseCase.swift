//
//  ListTasksUseCase.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import Foundation

struct ListTasksUseCase {
    let repository: TaskRepository
    
    func execute() -> [Task] {
        repository.getAll()
    }
}
