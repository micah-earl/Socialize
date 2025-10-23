import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Enable notifications", isOn: $notificationsEnabled)
                    Toggle("Dark Mode", isOn: $darkMode)
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
