//
//  ContentView.swift
//  todolist
//
//  Created by Mauricio Cousillas on 12/4/19.
//  Copyright © 2019 Mauricio Cousillas. All rights reserved.
//

import SwiftUI

struct TodoItem: Identifiable {
  let id: Int
  let title: String
  let accessibilityLabel: String
  var done: Bool = false
}

struct ContentView: View {
  @State var todos = [
     TodoItem(id: 1, title: "Buy more baldo", accessibilityLabel: "Buy more baldo"),
     TodoItem(id: 2, title: "Invite GuriC to after",
              accessibilityLabel: "Invite guriso to after"),
     TodoItem(id: 3, title: "Expresso", accessibilityLabel: "Expresso")
  ]

  @State var showAlert = false

  var body: some View {
    VStack {
      Text("Kim's todo list")
        .font(.title)
        .fontWeight(.heavy)
        .accessibility(label: Text("Kim's todo list"))
      ForEach(todos) { todo in
        HStack {
          Text(todo.title)
            .font(.headline)
          Image(systemName: todo.done ? "checkmark.square.fill" : "square")
        }
        .padding()
        .accessibilityElement()
        .accessibility(
          label: Text("\(todo.accessibilityLabel) \(todo.done ? "done" : "pending" )")
        ).accessibility(addTraits: .isButton)
        .accessibility(
          hint: Text("Double tap to mark as \(todo.done ? "pending" : "done")")
        )
        .onTapGesture {
          self.updateTodo(id: todo.id)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      Spacer()
    }.alert(isPresented: $showAlert) {
      Alert(
        title: Text("Finished!"),
        message: Text("All your tasks are done"),
        dismissButton: .default(Text("Got it!"))
      )
    }
  }

  func updateTodo(id: Int) {
    guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
    var todo = todos[index]
    todo.done = !todo.done
    todos[index] = todo
    showAlert = todos.reduce(true) { $0 && $1.done }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
