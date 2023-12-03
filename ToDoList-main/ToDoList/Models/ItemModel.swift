//
//  ItemModel.swift
//  ToDoList
//
//  Created by Denis DRAGAN on 29.10.2023.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    var isCompleted: Bool
    let dueDate: Date?
    let description: String
    
    init(id: String = UUID().uuidString, title: String, isComplated: Bool, dueDate: Date? = nil, description: String) {
        self.id = id
        self.title = title
        self.isCompleted = isComplated  // Initialize isCompleted here
        self.dueDate = dueDate
        self.description = description
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isComplated: !isCompleted, dueDate: dueDate, description: description)
    }

    var isExpired: Bool {
        if let dueDate = dueDate {
            return Date() > dueDate
        }
        return false
    }
}
