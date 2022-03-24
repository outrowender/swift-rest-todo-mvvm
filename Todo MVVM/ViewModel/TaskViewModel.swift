//
//  TaskViewModel.swift
//  Todo MVVM
//
//  Created by Wender Patrick on 23/03/22.
//

import Foundation

class TaskViewModel: ObservableObject {
    
    // essa variável pode ser observado pela View. Se esse valor muda, a View reage.
    @Published var tasks : [TaskModel] = []
    
    /// Carrega a lista de tarefas vindas da API
    func fetchData() {
        // a classe que organiza as tasks é chamada aqui.
        // uma função é inicializada no parâmetro completion que é chamado quando a requisição termina.
        TasksApi.getTasks(completion: { result in
            switch result { // o tipo de resposta vindo da api, é tratado aqui
            case .success(let tasks):
                DispatchQueue.main.async {
                    // caso sucesso, o objeto tasks é atualizado com as tarefas vindas da API em uma thread principal.
                    self.tasks = tasks
                }
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
    /// Adiciona uma nova task.
    func addTask(task: TaskModel) {
        // nesse caso, o objeto task é passado para a api
        TasksApi.saveTask(task: task, completion: { result in
            switch result {
            case .success():
                print("task saved")
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
    /// Remove uma task usando o ID
    func removeTask(id: Int) {
        TasksApi.deleteTask(id: id, completion: { result in
            switch result {
            case .success():
                // o método que carrega a lista é chamado quando uma tarefa é removida.
                // a lista precisa ser atualizada e esse método cuida de tudo.
                self.fetchData()
                print("task deleted: \(id)")
            case .failure(let failure):
                print(failure)
            }
        })
    }
    
}
