//
//  ToggleTaskUseCase.swift
//  ToDo
//
//  Created by Jean Camargo on 29/03/25.
//

import Foundation

struct ToggleTaskUseCase {
    func execute(task: Task) -> Task {
        var copy = task
        copy.isDone.toggle()
        
        return copy
    }
}
