//
//  SettingsView.swift
//  ToDoList
//
//  Created by Darpon Chakma on 22/11/23.
//

import SwiftUI
import Firebase

struct User {
    var name: String
    var email: String
    // Add other user information as needed
}

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var user: User

    init(user: User) {
        self._user = State(initialValue: user)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { _ in
                            // Toggle dark mode here if needed
                            // For example: UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                        }
                }

                Section(header: Text("User Information")) {
                    TextField("Name", text: $user.name)
                    TextField("Email", text: $user.email)
                        .disabled(true) // Email is not editable in this example

                    // Add other fields for additional user information

                    Button("Save Changes") {
                        // Save changes to the user information, e.g., update the user data in the database
                        saveChanges()
                    }
                }

                Section(header: Text("Authentication")) {
                    Button("Sign Out") {
                        signOut()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
        }
    }

    private func saveChanges() {
        // Save changes to user information in the database
        // Update the user's name, email, etc.
    }

    private func signOut() {
        do {
            try Auth.auth().signOut()
            // Handle sign-out success, e.g., navigate to the login screen
        } catch {
            // Handle sign-out error
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(user: User(name: "John Doe", email: "john@example.com"))
    }
}
