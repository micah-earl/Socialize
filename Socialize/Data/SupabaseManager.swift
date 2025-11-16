//
//  SupabaseManager.swift
//  Socialize
//
//  Created by Micah Earl on 11/11/25.
//

import Foundation
import Supabase

struct SupabaseService {
    static let shared = SupabaseService()

    // Update these two constants with your real values
    private let projectURL = URL(string: "https://cifpogiklwszagnqbzie.supabase.co")!
    private let anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpZnBvZ2lrbHdzemFnbnFiemllIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA5NjM3ODYsImV4cCI6MjA3NjUzOTc4Nn0.Ygf6ky7P_R97FS2a7uJIqxaxnaukC2hqX5NyIofSQk4"

    let client: SupabaseClient

    private init() {
        self.client = SupabaseClient(
            supabaseURL: projectURL,
            supabaseKey: anonKey
        )
    }
}
