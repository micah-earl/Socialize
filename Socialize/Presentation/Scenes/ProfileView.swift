//
//  ProfileView.swift
//  socialize
//

import SwiftUI

struct ProfileView: View {
    @Environment(SocializeStore.self) private var store
    var me: User? { store.currentUserId.flatMap { store.users[$0] } }

    var myActivities: [Activity] {
        guard let me else { return [] }
        return store.activities.values.filter { $0.authorId == me.id }.sorted { $0.date < $1.date }
    }

    var body: some View {
        NavigationStack {
            List {
                if let me {
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .center, spacing: 12) {
                                Circle()
                                    .fill(Color.accentColor.opacity(0.2))
                                    .frame(width: 54, height: 54)
                                    .overlay(Image(systemName: "person.fill").foregroundStyle(.tint))
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(me.fullName).font(.title3).bold()
                                    Text("@\(me.username)").font(.subheadline).foregroundStyle(.secondary)
                                }
                            }
                            Text(me.bio).font(.body)
                        }
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color(uiColor: .secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(Color.gray.opacity(0.15))
                        )
                        .listRowInsets(EdgeInsets(top: 12, leading: 16, bottom: 4, trailing: 16))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                Section("My Activities") {
                    ForEach(myActivities) { activity in
                        NavigationLink(value: activity) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(activity.title).font(.headline)
                                HStack(spacing: 8) {
                                    Image(systemName: "calendar").foregroundStyle(.secondary)
                                    Text(activity.date, style: .date).font(.footnote).foregroundStyle(.secondary)
                                }
                            }
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(uiColor: .secondarySystemBackground))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .strokeBorder(Color.gray.opacity(0.15))
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Profile")
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(activity: activity)
            }
        }
    }
}
