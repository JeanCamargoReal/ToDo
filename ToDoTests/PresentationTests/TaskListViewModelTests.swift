//
//  TaskListViewModelTests.swift
//  ToDo
//
//  Created by Jean Camargo on 22/04/25.
//

import XCTest
@testable import ToDo

final class TaskListViewModelTests: XCTestCase {
    func test_addValidTask_shouldAppendToTask() {
        // Given
        let repo = InMemoryTaskRepository()
        let vm = makeViewModel(repository: repo)
        
        // When
        vm.addTask(title: "Nova tarefa")
        
        // Then
        XCTAssertEqual(vm.tasks.count, 1)
        XCTAssertEqual(vm.tasks.first?.title, "Nova tarefa")
    }
    
    func test_addEmptyTask_shouldSetErrorMessage() {
            // Given
            let repo = InMemoryTaskRepository()
            let vm = makeViewModel(repository: repo)

            // When
            vm.addTask(title: " ")

            // Then
            XCTAssertEqual(vm.tasks.count, 0)
            XCTAssertEqual(vm.errorMessage, CreateTaskError.emptyTitle.message)
    }
    
    func test_toggleTask_shouldUpdateIsDone() {
        // Given
        let repo = InMemoryTaskRepository()
        let task = Task(id: UUID(), title: "Ler", isDone: false)
        repo.add(task: task)
        let vm = makeViewModel(repository: repo)
        
        // When
        vm.toggleTask(withId: task.id)
        
        // Then
        XCTAssertTrue(vm.tasks.first?.isDone ?? false)
    }
    
    func test_deleteTask_shouldRemoveItFromTasks() {
        // Given
        let repo = InMemoryTaskRepository()
        let task = Task(id: UUID(), title: "Remover", isDone: false)
        repo.add(task: task)
        let vm = makeViewModel(repository: repo)
        
        // When
        vm.deleteTask(withId: task.id)
        
        // Then
        XCTAssertTrue(vm.tasks.isEmpty)
    }
    
    // MARK: - Helper
    private func makeViewModel(repository: TaskRepository) -> TaskListViewModel {
        return TaskListViewModel(
            createTask: CreateTaskUseCase(),
            listTasks: ListTasksUseCase(repository: repository),
            deleteTask: DeleteTaskUseCase(repository: repository),
            toggleTask: ToggleTaskUseCase()
        )
    }
}
