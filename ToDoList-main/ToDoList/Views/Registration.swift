//
//  Registration.swift
//  ToDoList
//
//  Created by Darpon Chakma on 22/11/23.
//

import SwiftUI
import Firebase

struct Registration: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var registrationError: String?
    @State private var isRegistrationSuccessful = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.teal.ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.5)
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 100))
                        .padding(.bottom, 30)
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    
                    Button("Register") {
                        // Call a function to handle registration
                        register()
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: 290)
                    .background(Color.blue)
                    .cornerRadius(50)
                    .padding()
                }
                .padding(.horizontal, 30)
                
                
                if let error = registrationError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(
                    destination: Login(),
                    isActive:$isRegistrationSuccessful,
                    label: { EmptyView() }
                ).navigationBarHidden(true)
                    .hidden()
            }
            .navigationTitle("Register")
        }
    }
    
    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                registrationError = "Registration failed: \(error.localizedDescription)"
            } else if let authResult = authResult {
                // Registration successful, save user data to the database
                saveUserData(uid: authResult.user.uid)
            }
        }
    }
    
    private func saveUserData(uid: String) {
        let userData = [
            "username": username,
            "email": email
            // Add more fields as needed
        ]
        
        let databaseRef = Database.database().reference().child("users").child(uid)
        databaseRef.setValue(userData) { error, _ in
            if let error = error {
                registrationError = "Failed to save user data: \(error.localizedDescription)"
            } else {
                // User data saved successfully
                print("User data saved successfully")
                
                // Set isRegistrationSuccessful to true to trigger presentation of the Login view
                isRegistrationSuccessful = true
                
                // Create a new "todos" node under the user
                let todosRef = databaseRef.child("todos")
                todosRef.setValue(["placeholder": true])  // Add a placeholder value if needed
            }
        }
    }
}



struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        Registration()
    }
}
