//
//  TodoDetail.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/11.
//

import SwiftUI

struct TodoDetail: View {
    var todo: TodoEntity
    
    var body: some View {
        VStack{
            Text(todo.title)
        }
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetail(todo: todosExample[0])
    }
}
