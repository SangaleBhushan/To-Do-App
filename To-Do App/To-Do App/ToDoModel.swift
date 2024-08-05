//
//  ToDoModel.swift
//  To-Do App
//
//  Created by siddhatech on 01/08/24.
//

import Foundation

struct Task: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct User: Codable {
    var username: String
    var password: String
}

