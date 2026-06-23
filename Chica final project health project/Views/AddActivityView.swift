//
//  AddActivityView.swift
//  Chica final project health project
//
//  Created by Codex on 6/22/26.
//

import SwiftUI

struct AddActivityView: View { static func <;\>
    @Environment(\.dismiss) private var dismiss

    let onSave: (WorkoutEntry) -> Void

    @State private var activityName = ""
    @State private var selectedType = ActivityType.running
    @State private var date = Date()
    @State private var durationMinutes = 30
    @State private var calories = 200
    @State private var notes = ""

    private var canSave: Bool {
        !activityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            && durationMinutes > 0
            && calories >= 0
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Activity") {
                    TextField("Name", text: $activityName)

                    Picker("Type", selection: $selectedType) {
                        ForEach(ActivityType.allCases) { type in
                            Label(type.title, systemImage: type.icon)
                                .tag(type)
                        }
                    }
                }

                Section("Details") {
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])

                    Stepper(value: $durationMinutes, in: 1...600, step: 5) {
                        LabeledContent("Duration", value: "\(durationMinutes) min")
                    }

                    Stepper(value: $calories, in: 0...5000, step: 10) {
                        LabeledContent("Calories", value: "\(calories) kcal")
                    }
                }

                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("New Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveActivity()
                    }
                    .disabled(!canSave)
                }
            }
            .onAppear {
                if activityName.isEmpty {
                    activityName = selectedType.defaultName
                }
            }
            .onChange(of: selectedType) { _, newType in
                activityName = newType.defaultName
            }
        }
    }

    private func saveActivity() {
        let workout = WorkoutEntry(
            name: activityName.trimmingCharacters(in: .whitespacesAndNewlines),
            type: selectedType.title,
            duration: durationMinutes,
            calories: calories,
            date: date,
            icon: selectedType.icon,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )

        onSave(workout)
        dismiss()
    }
}

private enum ActivityType: String, CaseIterable, Identifiable {
    case running
    case walking
    case cycling
    case strength
    case yoga
    case swimming
    case other

    var id: String { rawValue }

    var title: String {
        switch self {
        case .running: return "Running"
        case .walking: return "Walking"
        case .cycling: return "Cycling"
        case .strength: return "Strength"
        case .yoga: return "Yoga"
        case .swimming: return "Swimming"
        case .other: return "Other"
        }
    }

    var defaultName: String {
        switch self {
        case .running: return "Run"
        case .walking: return "Walk"
        case .cycling: return "Ride"
        case .strength: return "Strength Training"
        case .yoga: return "Yoga"
        case .swimming: return "Swim"
        case .other: return "Workout"
        }
    }

    var icon: String {
        switch self {
        case .running: return "figure.run"
        case .walking: return "figure.walk"
        case .cycling: return "bicycle"
        case .strength: return "dumbbell"
        case .yoga: return "figure.yoga"
        case .swimming: return "figure.pool.swim"
        case .other: return "figure.mixed.cardio"
        }
    }
}

#Preview {
    AddActivityView { _ in }
}
