//
//  DeleteTaskUseCaseTests.swift
//  ToDo
//
//  Created by Jean Camargo on 29/03/25.
//

import XCTest
@testable import ToDo

final class DeleteTaskUseCaseTests: XCTestCase {
    
    func test_deleteTask_shouldRemoveTaskWithGivenID() {
        // Given
        let repo = InMemoryTaskRepository()
        let task1 = Task(id: UUID(), title: "Ler", isDone: false)
        let task2 = Task(id: UUID(), title: "Escrever", isDone: false)
        
        repo.add(task: task1)
        repo.add(task: task2)
        
        let sut = DeleteTaskUseCase(repository: repo)
        
        // When
        sut.execute(id: task1.id)
        
        // Then
        let tasks = repo.getAll()
        
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks[0].id, task2.id)
    }
    
    func test_deleteTask_withUnknownID_shoudNotRemoveAnything() {
        /// Valida um caso de borda (edge case): quando o id não corresponde
        ///  a nenhuma tarefa, nada deve acontecer.
        
        // Given
        let repo = InMemoryTaskRepository()
        let task = Task(id: UUID(), title: "Acordar cedo", isDone: false)
        
        repo.add(task: task)
        
        let sut = DeleteTaskUseCase(repository: repo)
        
        // When
        sut.execute(id: UUID()) // ID inexistente
        
        // Then
        XCTAssertEqual(repo.getAll().count, 1)
    }
    
    func test_deleteTask_whenListIsEmpty_shouldDoNothing() {
        /// Valida que nenhum crash ocorre ao tentar remover de uma lista vazia,
        /// e que o repositório continua consistente.
            
        // Given
        let repository = InMemoryTaskRepository()
        let sut = DeleteTaskUseCase(repository: repository)
        let id = UUID()
        
        // When
        sut.execute(id: id)
        
        // Then
        XCTAssertEqual(repository.getAll().count, 0)
    }
    
    func test_deleteTask_removeAllTaksOneByOne_shouldResutInEmptyList() {
        /// Valida que a exclusão em sequência de todas as tarefas resulta
        /// numa lista vazia ao final.
        
        // Given
        let repository = InMemoryTaskRepository()
        let tasks = [
            Task(id: UUID(), title: "A", isDone: false),
            Task(id: UUID(), title: "B", isDone: true),
            Task(id: UUID(), title: "C", isDone: false)
        ]
        
        tasks.forEach { repository.add(task: $0) }
        
        let sut = DeleteTaskUseCase(repository: repository)
        
        // When
        for task in tasks {
            sut.execute(id: task.id)
        }
        
        // Then
        XCTAssertTrue(repository.getAll().isEmpty)
    }
    
    func test_deleteTask_twiceWithSameID_shouldNotCrashOrRemoveMore() {
        /// Garante que o sistema é idempotente nesse contexto: tentar deletar
        /// algo já deletado não quebra o comportamento.
        
        // Given
        let repository = InMemoryTaskRepository()
        let task = Task(id: UUID(), title: "Unica", isDone: false)
        repository.add(task: task)
        
        let sut = DeleteTaskUseCase(repository: repository)
        
        // When
        sut.execute(id: task.id) // primeira vez (remove)
        sut.execute(id: task.id) // segunda vez (não existe mais)
        
        // Then
        XCTAssertTrue(repository.getAll().isEmpty)
    }
}
