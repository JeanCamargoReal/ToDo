//
//  ListTasksUseCaseTests.swift.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import XCTest
@testable import ToDo

final class ListTasksUseCaseTests: XCTestCase {
    
    func test_listTasks_returnsTasksFromRepository() {
        // Given
        let repository = InMemoryTaskRepository()
        repository.add(task: Task(id: UUID(), title: "Tarefa 1", isDone: false))
        repository.add(task: Task(id: UUID(), title: "Tarefa 2", isDone: true))
        
        let sut = ListTasksUseCase(repository: repository)
        
        // When
        let tasks = sut.execute()
        
        // Then
        XCTAssertEqual(tasks.count, 2)
        XCTAssertEqual(tasks[0].title, "Tarefa 1")
        XCTAssertEqual(tasks[1].title, "Tarefa 2")
    }
}
