//
//  UserDefaultsTaskRepositoryTests.swift
//  ToDo
//
//  Created by Jean Camargo on 21/04/25.
//

import XCTest
@testable import ToDo

final class UserDefaultsTaskRepositoryTests: XCTestCase {
    var repository: UserDefaultsTaskRepository!
    var defaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        let suiteName = "com.tdd.todo.tests"
        defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        repository = UserDefaultsTaskRepository(defaults: defaults)
    }
    
    func test_addTask_shouldPersistTask() {
        let task = Task(id: UUID(), title: "Comprar pão", isDone: false)
        
        repository.add(task: task)
        let tasks = repository.getAll()
        
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks[0].title, "Comprar pão")
    }
    
    func test_deleteTask_shouldRemoveTask() {
        let task = Task(id: UUID(), title: "Lavar louça", isDone: false)
        repository.add(task: task)
        
        repository.delete(by: task.id)
        
        XCTAssertTrue(repository.getAll().isEmpty)
    }
    
    func test_repository_shouldLoadSavedTasksFromDefaults() {
        let task = Task(id: UUID(), title: "Ler", isDone: false)
        repository.add(task: task)
        
        // Cria novo respositorio para simular reload
        let reloadedRepository = UserDefaultsTaskRepository(defaults: defaults)
        let tasks = reloadedRepository.getAll()
        
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks[0].title, "Ler")
    }
}
