//
//  TodoLists.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/09.
//

import SwiftUI

struct TodoLists: View {
    @State var todos: [TodoEntity]
    @State var filterMode: FilterTodoStatus = .all
    @State var todoID = 100
    @State var isAddMode = false
    @State var isEditMode = false
    @State var showsDeleteConfirmation = false
    @State var showsBulkDeleteConfirmation = false
    @State var targetTodo: TodoEntity = TodoEntity(id: 0, title: "", isCompleted: false, limitTime: Date())
    @State var checkedTodoIDs = Set<Int>()
    @State var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List(filterTodo(todos: todos), selection: $checkedTodoIDs) { todo in
                Text(todo.title)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            targetTodo = todo
                            showsDeleteConfirmation.toggle()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        Button(action:
                                {
                            targetTodo = todo
                            isEditMode.toggle()
                        }
                        ){
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                    .swipeActions(edge: .leading) {
                        if todo.isCompleted {
                            Button(action:
                                    {
                                unCompleteTodo(id: todo.id)
                            }
                            ){
                                Label("Edit", systemImage: "tray.full.fill")
                            }
                            .tint(.green)
                        } else {
                            Button(action:
                                    {
                                completeTodo(id: todo.id)
                            }
                            ){
                                Label("Edit", systemImage: "tray.fill")
                            }
                            .tint(.green)
                        }
                    }
            }
            .navigationTitle("Todoリスト")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if editMode.isEditing == false {
                        Button(action: {
                            isAddMode = true
                        }) {
                            Image(systemName: "plus.circle")
                        }
                    } else {
                        Button(action: {
                            showsBulkDeleteConfirmation.toggle()
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                        .disabled(checkedTodoIDs.isEmpty)
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        filterMode = .all
                    }) {
                        VStack {
                            Image(systemName: "checklist")
                            Text("全て")
                                .font(.caption2)
                        }
                    }
                    .tint(filterMode == .all ? .blue : .gray)
                    .padding()
                    Spacer()
                    Button(action: {
                        filterMode = .completed
                    }) {
                        VStack {
                            Image(systemName: "tray.fill")
                            Text("完了")
                                .font(.caption2)
                        }
                    }
                    .tint(filterMode == .completed ? .blue : .gray)
                    Spacer()
                    Button(action: {
                        filterMode = .notCompleted
                    }) {
                        VStack {
                            Image(systemName: "tray.full.fill")
                            Text("未完了")
                                .font(.caption2)
                        }
                    }
                    .tint(filterMode == .notCompleted ? .blue : .gray)
                    .padding()
                }
            }
            .sheet(isPresented: $isAddMode) {
                TodoInput(addTodo: addTodo, closeAddTodo: closeAddTodo)
            }
            .sheet(isPresented: $isEditMode) {
                TodoEdit(closeEditTodo: closeEditTodo, updateTodo: updateTodo(todo:), todoEdit: TodoEditEntity(title: targetTodo.title, isCompleted: targetTodo.isCompleted, limitTime: targetTodo.limitTime))
            }
            .alert("\(targetTodo.title)を本当に削除しますか？",
                   isPresented: $showsDeleteConfirmation) {
                Button(role: .destructive, action: {
                    deleteTodo(todoID: targetTodo.id)
                    showsDeleteConfirmation.toggle()
                }) {
                    Text("削除する")
                }
            }
           .alert("選択した\(checkedTodoIDs.count)件を本当に削除しますか？",
                  isPresented: $showsBulkDeleteConfirmation) {
               Button(role: .destructive, action: {
                   bulkDeleteTodo()
                   showsBulkDeleteConfirmation = false
                   checkedTodoIDs = Set<Int>()
               }) {
                   Text("削除する")
               }
           }
                  .environment(\.editMode, $editMode)
        }
    }
    
    private func filterTodo(todos: [TodoEntity]) -> [TodoEntity] {
        switch filterMode {
        case .all:
            return todos
        case .completed:
            let completedTodos = todos.filter { $0.isCompleted == true }
            
            return completedTodos
        case .notCompleted:
            let notCompletedTodos = todos.filter { $0.isCompleted == false }
            
            return notCompletedTodos
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
    
    private func closeEditTodo() {
        isEditMode.toggle()
    }
    
    private func updateTodo(todo: TodoEditEntity) {
        let index = todos.firstIndex(where: { $0.id == targetTodo.id })
        
        if let index = index {
            todos[index] = TodoEntity(id: targetTodo.id, title: todo.title, isCompleted: todo.isCompleted, limitTime: todo.limitTime)
        }
    }
    
    private func completeTodo(id: Int) {
        let index = todos.firstIndex(where: { $0.id == id })
        
        if let index = index {
            todos[index].isCompleted = true
        }
    }
    
    private func unCompleteTodo(id: Int) {
        let index = todos.firstIndex(where: { $0.id == id })
        
        if let index = index {
            todos[index].isCompleted = false
        }
    }
    
    private func bulkDeleteTodo() {
        checkedTodoIDs.forEach { id in
            deleteTodo(todoID: id)
        }
    }
}

struct TodoLists_Previews: PreviewProvider {
    static var previews: some View {
        TodoLists(todos: todosExample)
    }
}
