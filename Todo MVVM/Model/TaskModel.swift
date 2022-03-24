//
//  TaskModel.swift
//  Todo MVVM
//
//  Created by Wender Patrick on 23/03/22.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    let id: Int
    let author, content: String
    let priority: Priority
}

enum Priority: String, Identifiable, CaseIterable, Codable {
    var id : String { rawValue }
    
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
