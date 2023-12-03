//
//  ListRowView.swift
//  ToDoList
//
//  Created by Denis DRAGAN on 29.10.2023.
//

import SwiftUI

struct ListRowView: View {
    let item: ItemModel
    
    var body: some View {
        HStack {
            // Display an image based on whether 'item' is completed or not.
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .red) // Set the foreground style of the image.
            Text(item.title) // Display the title of the 'item'.
            Spacer()
        }
    }
}
