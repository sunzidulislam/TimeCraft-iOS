//
//  ListView.swift
//  ToDoList
//
//  Created by Denis DRAGAN on 29.10.2023.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }.navigationBarHidden(true)
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationView {
                ExploreView()
            }.navigationBarHidden(true)
            .tabItem {
                Label("Explore", systemImage: "star.fill")
            }

            NavigationView {
                SettingsView(user: User(name: "John Doe", email: "john@example.com"))
            }.navigationBarHidden(true)
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}

struct HomeView: View {
@EnvironmentObject var listViewModel: ListViewModel

    var body: some View {
                ZStack {
                        if listViewModel.items.isEmpty {
                            Text("No items to display.")
                                .foregroundColor(.gray)
                                .font(.headline)
                                .padding()
                                .transition(AnyTransition.opacity.animation(.easeInOut))
                        } else {
                            List {
                                ForEach(listViewModel.items) { item in
                                    NavigationLink(destination: ItemDetailView(item: item)) {
                                        ListRowView(item: item)
                                            .onTapGesture {
                                                withAnimation(.linear(duration: 0.15)) {
                                                    listViewModel.updateItem(item: item)
                                                }
                                            }
                                    }
                                }
                                .onDelete(perform: listViewModel.deleteItem)
                                .onMove(perform: listViewModel.moveItem)
                            }
                            .listStyle(.plain)
                        }
                    }
                    .navigationBarItems(
                        leading: EditButton(),
                        trailing: NavigationLink("Add", destination: AddView())
                    )
                    .navigationTitle("To-Do List 📝")
        
                }
            }


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ListViewModel())
    }
}
