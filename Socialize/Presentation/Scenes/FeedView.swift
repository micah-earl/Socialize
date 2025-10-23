//
//  FeedView.swift
//  socialize
//

import SwiftUI

struct FeedView: View {
    @Environment(SocializeStore.self) private var store

    var body: some View {
        NavigationStack {
            List(store.feedActivities()) { activity in
                NavigationLink(value: activity) {
                    ActivityRow(activity: activity)
                        .padding(12)
                        .background(.background)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(Color.gray.opacity(0.15))
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(uiColor: .secondarySystemBackground))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
            .navigationTitle("Feed")
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(activity: activity)
            }
        }
    }
}

private struct ActivityRow: View {
    @Environment(SocializeStore.self) private var store
    let activity: Activity

    var author: User? { store.users[activity.authorId] }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(author?.fullName ?? "Unknown").font(.headline)
                Spacer()
                Text(activity.category)
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.accentColor.opacity(0.12))
                    .clipShape(Capsule())
            }
            Text(activity.title).font(.body)
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse").foregroundStyle(.secondary)
                Text(activity.location).font(.footnote).foregroundStyle(.secondary)
                Spacer()
                Image(systemName: "calendar").foregroundStyle(.secondary)
                Text(activity.date, style: .date).font(.footnote).foregroundStyle(.secondary)
            }
        }
    }
}
