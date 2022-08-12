//
//  TodoEntity.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/09.
//

import Foundation
struct TodoEntity: Identifiable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var limitTime: Date
}

struct TodoInputEntity {
    var title: String
    var limitTime: Date
}

let todosExample: [TodoEntity] = (1..<100).map { number in
    TodoEntity(id: number, title: "タイトル\(number)", isCompleted: number % 2 == 0, limitTime: Calendar.current.date(byAdding: .day, value: number, to: Date())!)
}
