//
//  SignInView.swift
//  Socialize
//
//  Created by Micah Earl on 11/24/25.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Sign In") {
                // Sign in action
            }
            .padding()
            
            Button("Don't have an account? Sign Up") {
                // Navigate to sign up
            }
            .padding()
        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    SignInView()
}
