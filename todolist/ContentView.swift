//
//  ContentView.swift
//  todolist
//
//  Created by Mauricio Cousillas on 12/4/19.
//  Copyright © 2019 Mauricio Cousillas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var viewModel: TodoViewModel

  var body: some View {
    VStack(alignment: .leading) {
    ScrollView {
        Text("Groceries")
          .font(.title)
          .fontWeight(.heavy)
          .accessibility(label: Text("Grocery List"))
        ForEach(viewModel.todos) { todo in
          HStack {
            Text(todo.title)
              .font(.headline)
            Image(systemName: todo.done ? "checkmark.square.fill" : "square")
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical)
          .accessibilityElement()
          .accessibility(
            label: Text("\(todo.title) \(todo.done ? "done" : "pending" )")
          ).accessibility(addTraits: .isButton)
          .accessibility(
            hint: Text("Double tap to mark as \(todo.done ? "pending" : "done")")
          )
          .onTapGesture {
            self.viewModel.updateTodo(id: todo.id)
          }
        }
      }
      InputView(
        onSubmit: viewModel.addTodo,
        text: $viewModel.newTodo
      )
    }
    .padding()
    .alert(isPresented: $viewModel.showAlert) {
      Alert(
        title: Text("Finished!"),
        message: Text("All your tasks are done"),
        dismissButton: .default(Text("Got it!"))
      )
    }
  }


}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
