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
    @State var deleteTodo: TodoEntity = TodoEntity(id: 0, title: "", isCompleted: false, limitTime: Date())
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { todo in
                    Text(todo.title)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            deleteTodo = todo
                            showsDeleteConfirmation.toggle()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button(action:
                                {isAddMode.toggle()}
                        ){
                            Label("Edit", systemImage: "pencil")
                                .foregroundColor(.blue)
                        }
                    }
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
            .sheet(isPresented: $isAddMode) {
                TodoInput(addTodo: addTodo, closeAddTodo: closeAddTodo)
            }
            .alert("\(deleteTodo.title)を本当に削除しますか？",
                   isPresented: $showsDeleteConfirmation) {
                Button(role: .destructive, action: {
                    deleteTodo(todoID: deleteTodo.id)
                    showsDeleteConfirmation.toggle()
                }) {
                    Text("削除する")
                }
            }
        }
    }
    
    private func addTodo(todo: TodoInputEntity) {
        todos.insert(TodoEntity(id: todoID, title: todo.title, isCompleted: false, limitTime: todo.limitTime), at: 0)
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
