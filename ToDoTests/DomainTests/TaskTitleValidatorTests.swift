//
//  TaskTitleValidatorTests.swift
//  ToDo
//
//  Created by Jean Camargo on 30/03/25.
//

import XCTest
@testable import ToDo

final class TaskTitleValidatorTests: XCTestCase {

    func test_validate_withEmptyString_shouldReturnEmptyTitleError() {
        let result = TaskTitleValidator.validate("")
        XCTAssertEqual(result, .emptyTitle)
    }

    func test_validate_withWhitespaceOnly_shouldReturnEmptyTitleError() {
        let result = TaskTitleValidator.validate("     ")
        XCTAssertEqual(result, .emptyTitle)
    }

    func test_validate_withMoreThan100Characters_shouldReturnTooLongError() {
        let title = String(repeating: "a", count: 101)
        let result = TaskTitleValidator.validate(title)
        XCTAssertEqual(result, .tooLong)
    }

    func test_validate_withValidTitle_shouldReturnNil() {
        let result = TaskTitleValidator.validate("Estudar TDD")
        XCTAssertNil(result)
    }
}

