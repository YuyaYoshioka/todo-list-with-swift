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
    var closeAddTodo: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                VStack(alignment: .leading) {
                    Text("タイトル")
                        .padding(.leading)
                    TextField(
                        "",
                        text: $todoInput.title
                    )
                    .padding(4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.primary)
                    }
                    .padding([.leading, .trailing])
                }
                VStack(alignment: .leading) {
                    Text("内容")
                        .padding(.leading)
                    TextEditor(text: $todoInput.description)
                        .overlay {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.primary)
                        }                    .padding([.leading, .trailing])
                }
                DatePicker(
                    "期限",
                    selection: $todoInput.limitTime,
                    displayedComponents: [.date]
                )
                .environment(\.locale, Locale.init(identifier: "ja_JP"))
                .padding([.leading, .trailing])
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addTodo(todoInput)
                        closeAddTodo()
                    }) {
                        Text("追加")
                    }
                    .disabled(isButtonDisabled(todo: todoInput))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        closeAddTodo()
                    }) {
                        Text("キャンセル")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    private func isButtonDisabled(todo: TodoInputEntity) -> Bool {
        if todo.title.isEmpty {
            return true
        }
        if todo.description.isEmpty {
            return true
        }
        
        return false
    }
}

struct TodoInput_Previews: PreviewProvider {
    static var previews: some View {
        TodoInput(addTodo: {_ in addTodo(todo: todoInput)}, closeAddTodo: {})
    }
    
    static func addTodo(todo: TodoInputEntity) -> Void {
        print(todo)
    }
    
    private static let todoInput = TodoInputEntity(title: "タイトル1", description: "内容1", limitTime: Date())
}
