//
//  TaskInput.swift
//  Todo MVVM
//
//  Created by Wender Patrick on 23/03/22.
//

import SwiftUI

struct TaskInput: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // variáveis que tratam o status do formulário
    @State private var username: String = ""
    @State private var content: String = ""
    @State private var priority: Priority = .medium
    
    @ObservedObject var viewModel : TaskViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .frame(minHeight: 160, alignment: .leading)
            }
            Section {
                Picker(selection: $priority, label: Text("Priority")) {
                    ForEach(Priority.allCases){ priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                TextField("Author name", text: $username)
            }
            
            Button("Create", action: {
                // quando o botão criar é pressionado, uma nova TaskModel é instanciada com os valores do form
                self.viewModel.addTask(task: TaskModel(id: 0, author: username, content: content, priority: priority))
                
                // volta para a tela anterior
                self.presentationMode.wrappedValue.dismiss()
            })
            
        }
        .navigationTitle("Create Task")
    }
}

struct TaskInput_Previews: PreviewProvider {
    static var previews: some View {
        TaskInput(viewModel: TaskViewModel())
    }
}
