//
//  Test.swift
//  todo-list-with-swift
//
//  Created by 吉岡雄也 on 2022/08/13.
//

import SwiftUI

struct Test: View {
    @Environment(\.editMode) private var editMode
    @State private var name = "Maria Ruiz"

    var body: some View {
        NavigationView {
        Form {
            if editMode?.wrappedValue.isEditing == true {
                TextField("Name", text: $name)
            } else {
                Text(name)
            }
        }
        .animation(nil, value: editMode?.wrappedValue)
        .toolbar { // Assumes embedding this view in a NavigationView.
            EditButton()
        }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
