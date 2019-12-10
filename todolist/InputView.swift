//
//  InputView.swift
//  todolist
//
//  Created by Mauricio Cousillas on 12/10/19.
//  Copyright © 2019 Mauricio Cousillas. All rights reserved.
//

import SwiftUI

struct InputView: View {
  let onSubmit: () -> Void
  @Binding var text: String

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        TextField(
          "Add New Todo",
          text: $text,
          onCommit: {
            self.onSubmit()
          }
        )
        .accessibility(
          hint: Text("Tap return to submit")
        )
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray, lineWidth: 1)
        )

        Button(
          action: {
            self.onSubmit()
          },
          label: {
            Text("Submit")
          }
        )
        .accessibility(
          label: Text("Submit new todo item")
        )
      }
    }
  }
}
