//
//  DeleteTaskUseCase.swift
//  ToDo
//
//  Created by Jean Camargo on 29/03/25.
//

import Foundation

struct DeleteTaskUseCase {
    let repository: TaskRepository
    
    func execute(id: UUID) {
        repository.delete(by: id)
    }
}
