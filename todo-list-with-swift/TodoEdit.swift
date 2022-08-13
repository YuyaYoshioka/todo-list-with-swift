//
//  TodoEdit.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/13.
//

import SwiftUI

struct TodoEdit: View {
    var closeEditTodo: () -> Void
    var updateTodo: (TodoEditEntity) -> Void
    @State var todoEdit: TodoEditEntity

    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                VStack(alignment: .leading) {
                    Text("タイトル")
                        .padding(.leading)
                    TextField(
                        "",
                        text: $todoEdit.title
                    )
                    .padding(4)
                    .overlay {
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.primary)
                    }
                    .padding([.leading, .trailing])
                }
                Toggle(isOn: $todoEdit.isCompleted) {
                    Text("完了")
                }
                .padding([.leading, .trailing])
                DatePicker(
                    "期限",
                    selection: $todoEdit.limitTime,
                    displayedComponents: [.date]
                )
                .environment(\.locale, Locale.init(identifier: "ja_JP"))
                .padding([.leading, .trailing])
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        updateTodo(todoEdit)
                        closeEditTodo()
                    }) {
                        Text("更新")
                    }
                    .disabled(isButtonDisabled(todo: todoEdit))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        closeEditTodo()
                    }) {
                        Text("キャンセル")
                    }
                }
            }
        }
    }
    
    private func isButtonDisabled(todo: TodoEditEntity) -> Bool {
        if todo.title.isEmpty {
            return true
        }
        
        return false
    }
}

struct TodoEdit_Previews: PreviewProvider {
    static var previews: some View {
        TodoEdit(closeEditTodo: {}, updateTodo: {_ in updateTodo(todo: todo)}, todoEdit: todo)
    }
    
    private static func updateTodo(todo: TodoEditEntity) {
        print(todo)
    }
    
    private static let todo = TodoEditEntity(title: "タイトル", isCompleted: false, limitTime: Date())
}
