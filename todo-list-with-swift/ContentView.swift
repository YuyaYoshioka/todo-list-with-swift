//
//  ContentView.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/09.
//

import SwiftUI

struct ContentView: View {
    @State var todos: [TodoEntity] = todosExample
    
    var body: some View {
        TodoLists(todos: todos)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
