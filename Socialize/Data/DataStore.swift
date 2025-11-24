//
//  DataStore.swift
//  socialize
//
//  In-memory app state and simple recommendation logic
//

import Foundation
import Combine
import Supabase

@Observable
final class SocializeStore {
    private(set) var users: [UUID: User] = [:]
    private(set) var activities: [UUID: Activity] = [:]

    // Demo: current user is the first sample user
    var currentUserId: UUID?
    
    private let supabase = SupabaseService.shared.client

    init() {
        Task {
            try? await fetchAllData()
        }
    }

    private func fetchAllData() async throws {
        async let usersTask = fetchUsers()
        async let activitiesTask = fetchActivities()
        
        let (users, activities) = try await (usersTask, activitiesTask)
        
        self.users = Dictionary(uniqueKeysWithValues: users.map { ($0.id, $0) })
        self.activities = Dictionary(uniqueKeysWithValues: activities.map { ($0.id, $0) })
        self.currentUserId = users.first?.id
    }
    
    private func fetchUsers() async throws -> [User] {
        return try await supabase.from("users").select().execute().value
    }
    
    private func fetchActivities() async throws -> [Activity] {
        return try await supabase.from("activities").select().execute().value
    }

    func feedActivities() -> [Activity] {
        guard let currentUserId = currentUserId, let me = users[currentUserId] else { return [] }
        let followed = me.followingUserIds
        return activities.values
            .filter { followed.contains($0.authorId) || $0.authorId == currentUserId }
            .sorted { $0.date < $1.date }
    }

    func recommendedActivities(limit: Int = 20) -> [Activity] {
        guard let currentUserId = currentUserId, let me = users[currentUserId] else {
            return Array(activities.values.prefix(limit))
        }

        // Simple heuristic: prefer categories and authors adjacent to follow graph
        let followed = me.followingUserIds
        let myAuthored = Set(activities.values.filter { $0.authorId == currentUserId }.map { $0.category })

        return activities.values
            .sorted { a, b in
                score(activity: a, me: me, followed: followed, myCategories: myAuthored) >
                score(activity: b, me: me, followed: followed, myCategories: myAuthored)
            }
            .filter { !followed.contains($0.authorId) } // discover beyond your follows
            .prefix(limit)
            .map { $0 }
    }

    private func score(activity: Activity, me: User, followed: Set<UUID>, myCategories: Set<String>) -> Int {
        var s = 0
        if followed.contains(activity.authorId) { s += 10 }
        if myCategories.contains(activity.category) { s += 3 }
        s += activity.likedUserIds.intersection(followed).count
        // Prefer sooner events slightly
        if activity.date < Date().addingTimeInterval(60 * 60 * 24 * 7) { s += 1 }
        return s
    }

    func toggleFollow(userId: UUID) async throws {
        guard let meId = currentUserId else { return }
        guard var me = users[meId] else { return }
        if me.followingUserIds.contains(userId) {
            me.followingUserIds.remove(userId)
        } else {
            me.followingUserIds.insert(userId)
        }
        users[meId] = me
        
        try await supabase.from("users").update(me).eq("id", value: meId).execute()
    }

    func createActivity(title: String, description: String, category: String, date: Date, location: String) async throws {
        guard let meId = currentUserId else { return }
        let new = Activity(
            id: UUID(),
            authorId: meId,
            title: title,
            description: description,
            category: category,
            date: date,
            location: location,
            likedUserIds: []
        )
        try await supabase.from("activities").insert(new).execute()
        activities[new.id] = new
    }
}


