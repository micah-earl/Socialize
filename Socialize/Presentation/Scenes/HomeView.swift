//
//  ContentView.swift
//  Socialize
//
//  Created by Micah Earl on 10/23/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(SocializeStore.self) private var store

    var body: some View {
        ZStack {
            TabView {
                FeedView()
                    .tabItem { Label("Feed", systemImage: "house.fill") }

                DiscoverView()
                    .tabItem { Label("Discover", systemImage: "sparkles") }

                CreateActivityView()
                    .tabItem { Label("Create", systemImage: "plus.circle.fill") }

                MapView()
                    .tabItem { Label("Map", systemImage: "map.fill") }

                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape.fill") }

                ProfileView()
                    .tabItem { Label("Profile", systemImage: "person.fill") }
            }
            .tint(.accentColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ensures full-screen layout
        .ignoresSafeArea() // Optional: Extends into safe areas
    }
}

#Preview("HomeView") {
    HomeView()
}
