//
//  TodoViewModel.swift
//  todolist
//
//  Created by Mauricio Cousillas on 12/10/19.
//  Copyright © 2019 Mauricio Cousillas. All rights reserved.
//

import SwiftUI

struct TodoItem: Identifiable {
  let id: String
  let title: String
  var done: Bool = false
}

class TodoViewModel: ObservableObject {
  @Published var todos = [
   TodoItem(id: "1", title: "Milk"),
   TodoItem(id: "2", title: "Bread"),
   TodoItem(id: "3", title: "Coffee")
  ]

  @Published var showAlert = false

  @Published var newTodo = ""

  func updateTodo(id: String) {
    guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
    var todo = todos[index]
    todo.done = !todo.done
    todos[index] = todo
    showAlert = todos.reduce(true) { $0 && $1.done }
  }

  func addTodo() {
    let id = UUID().uuidString
    let todo = TodoItem(id: id, title: newTodo)
    todos.append(todo)
    newTodo = ""
  }
}
