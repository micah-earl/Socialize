//
//  CreateActivityView.swift
//  socialize
//

import SwiftUI

struct CreateActivityView: View {
    @Environment(SocializeStore.self) private var store: SocializeStore

    @State private var title: String = ""
    @State private var description: String = ""
    @State private var category: String = "Outdoors"
    @State private var date: Date = Date().addingTimeInterval(60 * 60 * 24)
    @State private var location: String = ""

    private var isValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Basics") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                Section("Details") {
                    TextField("Category", text: $category)
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    TextField("Location", text: $location)
                }
                Section {
                    Button {
                        Task {
                            do {
                                try await store.createActivity(title: title, description: description, category: category, date: date, location: location)
                                clearForm()
                            } catch {
                                // Handle error, maybe show an alert
                                print("Error creating activity: \(error)")
                            }
                        }
                    } label: {
                        Text("Post Activity")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(isValid ? Color.accentColor : Color.gray.opacity(0.3))
                            .foregroundStyle(isValid ? Color.white : Color.primary.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(!isValid)
                }
            }
            .navigationTitle("Create")
            .scrollDismissesKeyboard(.interactively)
        }
    }

    private func clearForm() {
        title = ""
        description = ""
        category = "Outdoors"
        date = Date().addingTimeInterval(60 * 60 * 24)
        location = ""
    }
}


