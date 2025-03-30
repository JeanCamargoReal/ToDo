//
//  CreateTaskError.swift
//  ToDo
//
//  Created by Jean Camargo on 30/03/25.
//

import Foundation

enum CreateTaskError: Error, Equatable {
    case emptyTitle
    case tooLong
}

extension CreateTaskError {
    var message: String {
        switch self {
        case .emptyTitle: return "O título não pode ser vazio."
        case .tooLong: return "O título deve ter no máximo 100 caracteres."
        }
    }
}
