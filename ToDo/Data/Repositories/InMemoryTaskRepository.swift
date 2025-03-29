//
//  InMemoryTaskRepository.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import Foundation

final class InMemoryTaskRepository: TaskRepository {
    
    private var tasks: [Task] = []
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func getAll() -> [Task] {
        return tasks
    }
    
    func delete(by id: UUID) {
        tasks.removeAll { $0.id == id }
    }
}
