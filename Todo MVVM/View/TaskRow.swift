//
//  TaskCellView.swift
//  Todo MVVM
//
//  Created by Wender Patrick on 23/03/22.
//

import SwiftUI

struct TaskRow: View {
    
    // esse componente é passado pra cá para renderizar os valores de cada task na lista
    var task: TaskModel
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(task.content)
                Text(task.author).font(.system(size: 10))
            }
            Spacer()
            switch task.priority {
                case .high:
                    Image(systemName: "flame.fill").foregroundColor(.red)
                case .medium:
                    Image(systemName: "flame.fill").foregroundColor(.orange)
                case .low:
                    Image(systemName: "flame.fill").foregroundColor(.blue)
            }
            
        }
        .padding(8)
    }
    
    // código responsável pelo preview
    struct TaskCellView_Previews: PreviewProvider {
        static var previews: some View {
            Group{
                TaskRow(task: TaskModel(
                    id: 1,
                    author: "Wender Patrick",
                    content: "Ipsum dolor",
                    priority: .low)
                )
                
                TaskRow(task: TaskModel(
                    id: 2,
                    author: "André Galvão",
                    content: "Ipsum dolor text",
                    priority: .medium)
                )
                
                TaskRow(task: TaskModel(
                    id: 2,
                    author: "Amanda Fernandes",
                    content: "Ipsum dolor text",
                    priority: .high)
                )
            }.previewLayout(.fixed(width: 300, height: 100))
            
        }
    }
}
