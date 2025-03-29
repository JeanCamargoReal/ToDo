//
//  ToggleTaskUseCaseTests.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import XCTest
@testable import ToDo

final class ToggleTaskUseCaseTests: XCTestCase {
    
    func test_toggleTask_shouldToggleIsDoneFromFalseToTrue() {
        // Given
        let task = Task(id: UUID(), title: "Ler artigo", isDone: false)
        let sut = ToggleTaskUseCase()
        
        // When
        let toggled = sut.execute(task: task)
        
        // Then
        XCTAssertTrue(toggled.isDone)
    }
    
    func test_toggleTask_shouldToggleIsDoneFromTrueToFalse() {
        // Given
        let task = Task(id: UUID(), title: "Dormir cedo", isDone: true)
        let sut = ToggleTaskUseCase()
        
        // When
        let toggled = sut.execute(task: task)
        
        // Then
        XCTAssertFalse(toggled.isDone)
    }
    
    func test_toggleTaskTwice_shouldReturnToOriginalState() {
        // Given
        let originalTask = Task(id: UUID(), title: "Ir à academia", isDone: false)
        let sut = ToggleTaskUseCase()
        
        // When
        let firstToggle = sut.execute(task: originalTask)
        let secondToggle = sut.execute(task: firstToggle)
        
        // Then
        XCTAssertEqual(secondToggle.isDone, originalTask.isDone)
        XCTAssertEqual(secondToggle.title, originalTask.title)
        XCTAssertEqual(secondToggle.id, originalTask.id)
    }
}
