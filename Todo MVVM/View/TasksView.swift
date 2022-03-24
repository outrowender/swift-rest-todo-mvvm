//
//  TasksView.swift
//  Todo MVVM
//
//  Created by Wender Patrick on 23/03/22.
//

import SwiftUI

struct TasksView: View {
    
    // a viewmodel é iniciada aqui, e os valores são observados
    @StateObject var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            List {
                // um foreach percorre a lista de tasks da viewmodel
                ForEach(viewModel.tasks){ task in
                    // o componente `TaskRow` é inicializado com um objeto `Task`
                    TaskRow(task: task)
                        .swipeActions {
                                    Button("Delete") {
                                        // um swipe action dispara a task que deve ser removida pela `task.id`
                                        viewModel.removeTask(id: task.id)
                                    }
                                    .tint(.red)
                                }
                }
            }
            .navigationTitle("Tasks list")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // esse botão chama a tela TaskInput passando a viewmodel como parâmetro
                    NavigationLink(destination: TaskInput(viewModel: viewModel)) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .onAppear {
                // toda vez que essa tela reaparece, o fetchData é chamada
                viewModel.fetchData()
            }
        }
        
    }
}

// código usado no preview do xcode
struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
