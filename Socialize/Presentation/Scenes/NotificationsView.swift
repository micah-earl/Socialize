import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(.tint)
                Text("No notifications yet")
                    .font(.headline)
                Text("When there’s something new, it’ll show up here.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Notifications")
        }
    }
}

#Preview {
    NotificationsView()
}
