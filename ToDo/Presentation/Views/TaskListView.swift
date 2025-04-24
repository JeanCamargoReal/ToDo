//
//  TaskListView.swift
//  ToDo
//
//  Created by Jean Camargo on 24/04/25.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel: TaskListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.tasks) { task in
                HStack {
                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            viewModel.toggleTask(withId: task.id)
                        }
                    
                    Text(task.title)
                        .strikethrough(task.isDone)
                }
            }
            .onDelete { indexSet in
                indexSet.map { viewModel.tasks[$0].id }.forEach {
                    viewModel.deleteTask(withId: $0)
                }
            }
        }
        .navigationTitle("Tarefas")
    }
}

#Preview {
    let tasks = [
        Task(id: UUID(), title: "Estudar Swift", isDone: false),
        Task(id: UUID(), title: "Fazer exercícios", isDone: true),
        Task(id: UUID(), title: "Ler Clean Architecture", isDone: false)
    ]

    let mockRepo = InMemoryTaskRepository()
    tasks.forEach { mockRepo.add(task: $0) }

    let viewModel = TaskListViewModel(
        createTask: CreateTaskUseCase(),
        listTasks: ListTasksUseCase(repository: mockRepo),
        deleteTask: DeleteTaskUseCase(repository: mockRepo),
        toggleTask: ToggleTaskUseCase()
    )

    return NavigationStack {
        TaskListView(viewModel: viewModel)
    }
}
