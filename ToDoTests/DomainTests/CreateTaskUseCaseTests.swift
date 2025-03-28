//
//  CreateTaskUseCaseTests.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import XCTest
@testable import ToDo

final class CreateTaskUseCaseTests: XCTestCase {
    
    func test_createTask_returnsTaskWithCorrectData() {
        // Given
        let sut = CreateTaskUseCase()
        let title = "Comprar pão"
        
        // When
        let task = sut.execute(title: title)
        
        // then
        XCTAssertEqual(task.title, title)
        XCTAssertFalse(task.isDone)
    }
}
