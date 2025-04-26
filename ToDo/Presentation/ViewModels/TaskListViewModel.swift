//
//  TaskListViewModel.swift
//  ToDo
//
//  Created by Jean Camargo on 21/04/25.
//

import Foundation

final class TaskListViewModel: ObservableObject {
    @Published private(set) var tasks: [Task] = []
    @Published var errorMessage: String?
    
    private let createTask: CreateTaskUseCase
    private let listTasks: ListTasksUseCase
    private let deleteTask: DeleteTaskUseCase
    private let toggleTask: ToggleTaskUseCase
    
    init(
        createTask: CreateTaskUseCase,
        listTasks: ListTasksUseCase,
        deleteTask: DeleteTaskUseCase,
        toggleTask: ToggleTaskUseCase
    ) {
        self.createTask = createTask
        self.listTasks = listTasks
        self.deleteTask = deleteTask
        self.toggleTask = toggleTask
        
        loadTasks()
    }
    
    func loadTasks() {
        tasks = listTasks.execute()
    }
    
    func addTask(title: String) {
        switch createTask.execute(title: title) {
        case .success(let task):
            tasks.append(task)
        case .failure(let error):
            handleError(error)
        }
    }
    
    func deleteTask(withId id: UUID) {
        deleteTask.execute(id: id)
        loadTasks()
    }
    
    func toggleTask(withId id: UUID) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        let toggled = toggleTask.execute(task: tasks[index])
        tasks[index] = toggled
    }
    
    private func handleError(_ error: CreateTaskError) {
        errorMessage = error.message
    }
}
