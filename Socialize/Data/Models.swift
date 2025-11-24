//
//  Models.swift
//  socialize
//
//  Core domain models for Socialize
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    let id: UUID
    var username: String
    var fullName: String
    var bio: String
    var followingUserIds: Set<UUID>
    
    enum CodingKeys: String, CodingKey {
        case id, username, bio
        case fullName = "full_name"
        case followingUserIds = "following_user_ids"
    }
}

struct Activity: Identifiable, Hashable, Codable {
    let id: UUID
    let authorId: UUID
    var title: String
    var description: String
    var category: String
    var date: Date
    var location: String
    var likedUserIds: Set<UUID>
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, category, date, location
        case authorId = "author_id"
        case likedUserIds = "liked_user_ids"
    }
}

enum SampleDataFactory {
    static func makeUsers() -> [User] {
        let aliceId = UUID()
        let bobId = UUID()
        let chrisId = UUID()

        var alice = User(id: aliceId, username: "alice", fullName: "Alice Kim", bio: "Hiking and coffee.", followingUserIds: [])
        var bob = User(id: bobId, username: "bobby", fullName: "Bob Rivera", bio: "Board games and brunch.", followingUserIds: [])
        let chris = User(id: chrisId, username: "chris", fullName: "Chris Patel", bio: "Live music and running.", followingUserIds: [])

        // Alice follows Bob
        alice.followingUserIds.insert(bobId)
        // Bob follows Chris
        bob.followingUserIds.insert(chrisId)

        return [alice, bob, chris]
    }

    static func makeActivities(users: [User]) -> [Activity] {
        guard users.count >= 3 else { return [] }
        let aliceId = users[0].id
        let bobId = users[1].id
        let chrisId = users[2].id

        return [
            Activity(
                id: UUID(),
                authorId: bobId,
                title: "Sunday Brunch",
                description: "Casual brunch at The Sunny Side. Join us at 11am!",
                category: "Food",
                date: Date().addingTimeInterval(60 * 60 * 72),
                location: "Downtown",
                likedUserIds: [aliceId]
            ),
            Activity(
                id: UUID(),
                authorId: aliceId,
                title: "Trail Hike",
                description: "3-mile loop at Redwood Trail, all levels welcome.",
                category: "Outdoors",
                date: Date().addingTimeInterval(60 * 60 * 24 * 5),
                location: "Redwood Trailhead",
                likedUserIds: []
            ),
            Activity(
                id: UUID(),
                authorId: chrisId,
                title: "Open Mic Night",
                description: "Local cafe open mic, performers and audience welcome.",
                category: "Music",
                date: Date().addingTimeInterval(60 * 60 * 96),
                location: "Maple Cafe",
                likedUserIds: []
            )
        ]
    }
}


