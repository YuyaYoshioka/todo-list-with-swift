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
    @State var showsDeleteConfirmation = false
    
    var body: some View {
        if isAddMode {
            TodoInput(addTodo: addTodo, closeAddTodo: closeAddTodo)
        } else {
            NavigationView {
                List {
                    ForEach(todos) { todo in
                        NavigationLink(
                            todo.title,
                            destination: TodoDetail(todo: todo)
                        )
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                showsDeleteConfirmation = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .alert("本当に削除しますか？",
                                   isPresented: $showsDeleteConfirmation) {
                                Button(action: {
                                    deleteTodo(todoID: todo.id)
                                }) {
                                    Text("削除する")
                                }
                                Button(action: {}) {
                                    Text("キャンセル")
                                }
                            }
                        }
                    }
                }
//                .navigationTitle("Todoリスト")
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
    
    private func closeAddTodo() {
        isAddMode = false
    }
    
    private func deleteTodo(todoID: Int) {
        let targetIndex = todos.firstIndex(where: { $0.id == todoID })
        todos.remove(at: targetIndex!)
    }
}

struct TodoLists_Previews: PreviewProvider {
    static var previews: some View {
        TodoLists(todos: todosExample)
    }
}
