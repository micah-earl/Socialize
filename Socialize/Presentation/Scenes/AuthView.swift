//
//  AuthView.swift
//  Socialize
//
//  Created by Micah Earl on 11/24/25.
//

import SwiftUI

struct AuthView: View {
    @State private var showSignIn = true

    var body: some View {
        NavigationView {
            if showSignIn {
                SignInView(showSignIn: $showSignIn)
            } else {
                SignUpView(showSignIn: $showSignIn)
            }
        }
    }
}

#Preview {
    AuthView()
}
