//
//  TodoEntity.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/09.
//

import Foundation
struct TodoEntity: Identifiable, Hashable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var limitTime: Date
}

struct TodoInputEntity {
    var title: String
    var limitTime: Date
}

struct TodoEditEntity {
    var title: String
    var isCompleted: Bool
    var limitTime: Date
}

enum FilterTodoStatus {
    case all
    case completed
    case notCompleted
}

let todosExample: [TodoEntity] = (1..<100).map { number in
    TodoEntity(id: number, title: "タイトル\(number)", isCompleted: number % 2 == 0, limitTime: Calendar.current.date(byAdding: .day, value: number, to: Date())!)
}
