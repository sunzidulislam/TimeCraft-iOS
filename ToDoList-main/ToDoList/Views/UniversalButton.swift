//
//  UniversalButton.swift
//  Trivia
//
//  Created by Stefan Bayne on 11/14/22.
//

import SwiftUI

struct UniversalButton: View {
    
    var text: String // passed for our button
    var background: Color = Color("ButtonColor") // bg for button
    
    var body: some View {
        
        Text(text)
            .foregroundColor(.white)
            .font(.headline)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.blue
                .cornerRadius(10))
    }
}

struct UniversalButton_Previews: PreviewProvider {
    static var previews: some View {
        UniversalButton(text: "Next")
    }
}
