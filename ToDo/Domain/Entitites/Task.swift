//
//  Task.swift
//  ToDo
//
//  Created by Jean Camargo on 28/03/25.
//

import Foundation

struct Task: Equatable, Codable, Identifiable {
    let id: UUID
    let title: String
    var isDone: Bool
}
