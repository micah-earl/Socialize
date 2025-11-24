//
//  SignUpView.swift
//  Socialize
//
//  Created by Micah Earl on 11/24/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Sign Up") {
                // Sign up action
            }
            .padding()
            
            Button("Already have an account? Sign In") {
                // Navigate to sign in
            }
            .padding()
        }
        .navigationTitle("Sign Up")
    }
}

#Preview {
    SignUpView()
}
