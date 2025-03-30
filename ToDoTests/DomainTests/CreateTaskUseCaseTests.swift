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
        let result = sut.execute(title: title)
        
        // Then
        switch result {
        case .success(let task):
            XCTAssertEqual(task.title, title)
            XCTAssertFalse(task.isDone)
        case .failure:
            XCTFail("Expected valid task, got failure")
        }
        
    }
    
    func test_createTask_withEmptyTitle_shouldReturnError() {
        // Given
        let sut = CreateTaskUseCase()
        let title = ""
        
        // When
        let result = sut.execute(title: title)
        
        // Then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .emptyTitle)
        case .success:
            XCTFail("Expected failure when creating task with empty title")
        }
    }
    
    func test_createTask_withOnlyWhitespace_shouldReturnError() {
        // Given
        let sut = CreateTaskUseCase()
        let title = "     "
        
        // When
        let result = sut.execute(title: title)
        
        // Then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .emptyTitle)
        case .success:
            XCTFail("Expected failure when creating task with only whitespace")
        }
    }
    
    func test_createTask_withTitleLongerThan100Characters_shouldReturnError() {
        // Given
        let sut = CreateTaskUseCase()
        let title = String(repeating: "a", count: 101)
        
        // When
        let result = sut.execute(title: title)
        
        // Then
        switch result {
        case .failure(let error):
            XCTAssertEqual(error, .tooLong)
        case .success:
            XCTFail("Expected failure when creating task with long title")
        }
    }
    
    func test_createTask_withExactly100Characters_shouldSucceed() {
        // Given
        let sut = CreateTaskUseCase()
        let title = String(repeating: "a", count: 100)
        
        // When
        let result = sut.execute(title: title)
        
        // Then
        switch result {
        case .success(let task):
            XCTAssertEqual(task.title, title)
        case .failure:
            XCTFail("Expected success for 100 character title")
        }
    }
    
    func test_createTask_withLessThan100Characters_shouldSucceed() {
        // Given
        let sut = CreateTaskUseCase()
        let title = String(repeating: "b", count: 99)
        
        // When
        let result = sut.execute(title: title)
        
        // Then
        switch result {
        case .success(let task):
            XCTAssertEqual(task.title, title)
        case .failure:
            XCTFail("Expected success for 99 character title")
        }
    }
}
