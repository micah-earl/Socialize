//
//  SocializeApp.swift
//  Socialize
//
//  Created by Micah Earl on 10/23/25.
//

import SwiftUI
import SwiftData

@main
struct SocializeApp: App {
    @State private var store = SocializeStore()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(store)
        }
    }
}
