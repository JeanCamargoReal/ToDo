//
//  TaskRepository.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import Foundation

protocol TaskRepository {
    func add(task: Task)
    func getAll() -> [Task]
}
