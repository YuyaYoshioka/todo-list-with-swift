//
//  TodoLists.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/09.
//

import SwiftUI

struct TodoLists: View {
    @State var todos: [TodoEntity]
    @State var todoID = 100
    @State var isAddMode = false
    
    var body: some View {
        if isAddMode {
            TodoInput(addTodo: addTodo)
        } else {
            NavigationView {
                ScrollView {
                    ForEach(todos) { todo in
                        NavigationLink(todo.title, destination: TodoDetail(todo: todo))
                    }
                }
                .navigationTitle("Todoリスト")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isAddMode = true
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
        }
    }
    
    private func addTodo(todo: TodoInputEntity) {
        todos.insert(TodoEntity(id: todoID, title: todo.title, description: todo.description, isCompleted: false, limitTime: todo.limitTime), at: 0)
        todoID += 1
    }
}

struct TodoLists_Previews: PreviewProvider {
    static var previews: some View {
        TodoLists(todos: todosExample)
    }
}
