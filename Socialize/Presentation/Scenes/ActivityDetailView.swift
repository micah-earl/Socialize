//
//  ActivityDetailView.swift
//  socialize
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(SocializeStore.self) private var store
    let activity: Activity

    var author: User? { store.users[activity.authorId] }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(activity.title).font(.largeTitle).bold()
                HStack {
                    Text(activity.category).font(.subheadline).padding(.vertical, 4).padding(.horizontal, 8).background(Color.gray.opacity(0.15)).clipShape(RoundedRectangle(cornerRadius: 8))
                    Spacer()
                    Text(activity.date, style: .date).font(.subheadline).foregroundStyle(.secondary)
                }
                if let author {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(author.fullName).font(.headline)
                            Text("@\(author.username)").font(.footnote).foregroundStyle(.secondary)
                        }
                        Spacer()
                        if let meId = store.currentUserId, meId != author.id {
                            Button(action: {
    Task {
        try? await store.toggleFollow(userId: author.id)
    }
}) {
                                let isFollowing = store.users[meId]?.followingUserIds.contains(author.id) == true
                                Text(isFollowing ? "Unfollow" : "Follow")
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(isFollowing ? Color.gray.opacity(0.2) : Color.accentColor.opacity(0.2))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("About").font(.headline)
                    Text(activity.description)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Location").font(.headline)
                    Text(activity.location).foregroundStyle(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Activity")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

