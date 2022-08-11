//
//  TodoInput.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/09.
//

import SwiftUI

struct TodoInput: View {
    @State private var todoInput: TodoInputEntity = TodoInputEntity(title: "", description: "", limitTime: Date())
    var addTodo: ((TodoInputEntity) -> Void)
    
    var body: some View {
        VStack {
            TextField(
                "Title",
                text: $todoInput.title
            )
            .border(.primary)
            Button(action: {
                addTodo(todoInput)
            }) {
                Text("追加")
            }
        }
    }
}

struct TodoInput_Previews: PreviewProvider {
    static var previews: some View {
        TodoInput(addTodo: {_ in addTodo(todo: todoInput)})
    }
    
    static func addTodo(todo: TodoInputEntity) -> Void {
        print(todo)
    }
    
    private static let todoInput = TodoInputEntity(title: "タイトル1", description: "内容1", limitTime: Date())
}
