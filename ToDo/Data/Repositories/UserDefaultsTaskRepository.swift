//
//  UserDefaultsTaskRepository.swift
//  ToDo
//
//  Created by Jean Camargo on 21/04/25.
//

import Foundation

final class UserDefaultsTaskRepository: TaskRepository {
    private let key = "saved_key"
    private let defaults: UserDefaults
    
    private var tasks: [Task] = []
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.tasks = load()
    }
    
    func add(task: Task) {
        tasks.append(task)
        save()
    }

    func getAll() -> [Task] {
        return tasks
    }

    func delete(by id: UUID) {
        tasks.removeAll { $0.id == id }
        save()
    }
    
    private func load() -> [Task] {
        guard let data = defaults.data(forKey: key) else {
            return []
        }
        return (try? JSONDecoder().decode([Task].self, from: data)) ?? []
    }
    
    private func save() {
        let data = try? JSONEncoder().encode(tasks)
        defaults.set(data, forKey: key)
    }
}
