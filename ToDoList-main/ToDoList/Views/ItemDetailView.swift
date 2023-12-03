//
//  ItemDetailView.swift
//  ToDoList
//
//  Created by Darpon Chakma on 22/11/23.
//

import SwiftUI

struct ItemDetailView: View {
    let item: ItemModel

    @State private var isCompletedAnimation = false

    var body: some View {
        VStack {
            VStack {
                Text(item.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 16)
                    .padding(.bottom, 8)

                HStack {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isCompleted ? .green : .gray)
                        .imageScale(.large)
                        .rotationEffect(Angle(degrees: isCompletedAnimation ? 360 : 0))
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: false))
                        .onAppear() {
                            isCompletedAnimation.toggle()
                        }

                    Text(item.isCompleted ? "Completed" : "Pending")
                        .foregroundColor(item.isCompleted ? .green : .orange)
                        .font(.headline)
                        .padding(.leading, 8)
                }
                .padding(.bottom, 16)

                if let dueDate = item.dueDate {
                    Text("Due Date: \(formattedDueDate)")
                        .foregroundColor(item.isExpired ? .red : .primary)
                        .font(.subheadline)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(item.isExpired ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                        )
                }

                if !item.description.isEmpty {
                    Text("Description:")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.top, 8)

                    Text(item.description)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 4)
            .padding()
        }
    }

    private var formattedDueDate: String {
        guard let dueDate = item.dueDate else {
            return "No Due Date"
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: dueDate)
    }
}

