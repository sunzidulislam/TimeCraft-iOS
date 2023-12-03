import SwiftUI

struct ContentView: View {
    
    @State private var isAnimated = false
    
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
                
                VStack(spacing: 10) {
                    Spacer()
                    
                    VStack(spacing: 0) {
                        // Title with pulsating animation
                        Text("TimeCraft!")
                        
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.blue)
                            .scaleEffect(isAnimated ? 1.2 : 1)
        
                            .animation(Animation.easeInOut(duration: 0.5))
    
            
                        
                        // Animated rotating image
                     
                        
                    }
                    
                    
                    
                    // Start button (you can add this later based on your design)
                    
                    // Login button with pulsating animation
                    NavigationLink(destination: Login()) {
                        UniversalButton(text: "Login")
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: 390)
                    
                    .navigationBarBackButtonHidden(true)
                    .animation(Animation.easeInOut(duration: 0.5))
                    
                    // Registration button with pulsating animation
                    NavigationLink(destination: Registration()) {
                        UniversalButton(text: "Register")
                    }
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: 390)
                    .background(Color.blue
                        .cornerRadius(50))
                    .navigationBarBackButtonHidden(true)
                    .animation(Animation.easeInOut(duration: 0.5))
                    
                    Spacer()
                }
                
                .padding()
                .onAppear() {
                    self.isAnimated.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color("ButtonColor").opacity(0.8) : Color("ButtonColor"))
            .cornerRadius(10)
    }
}
