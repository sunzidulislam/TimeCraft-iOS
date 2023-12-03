import SwiftUI
import Firebase

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var loginError: String?
    @State private var isLoggedIn = false

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
                  
                    
                    VStack {
                        Image(systemName: "lock")
                            .font(.system(size: 100))
                            .padding(.bottom, 30)
                        
                        
                        
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
                    }
                    .padding(.horizontal, 30)
                    
                    NavigationLink(destination: ListView(), isActive: $isLoggedIn) {
                        EmptyView()
                    }.navigationBarHidden(true)
                    Button("Login") {
                        // Call a function to handle the login
                        login()
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: 290)
                    .background(Color.blue
                        .cornerRadius(50))
                    .navigationBarBackButtonHidden(true)
                    
                    NavigationLink(destination: Text("Forgot Password?")) {
                        Text("Forgot Password?")
                            .foregroundColor(.blue)
                    }
                    
                    if let error = loginError {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    //Spacer()
                }
            }
            //.padding()
            .navigationTitle("Login")
        }
    }

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                loginError = "Login failed: \(error.localizedDescription)"
            } else {
                // Login successful, set isLoggedIn to true to trigger NavigationLink
                isLoggedIn = true
            }
        }
    }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
