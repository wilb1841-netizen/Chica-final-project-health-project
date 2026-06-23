//
//  SleepViews.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI
import SwiftData

struct SleepView: View {
    @Query(sort: \SleepEntry.wakeTime, order: .reverse) private var sleepEntries: [SleepEntry]
    @State private var isShowingAddSleep = false

    private var latestEntry: SleepEntry? {
        sleepEntries.first
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if let latestEntry {
                        SleepSummaryCard(entry: latestEntry)
                            .padding(.horizontal)
                    } else {
                        SleepEmptyState()
                            .padding(.horizontal)
                    }

                    if !sleepEntries.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            SectionHeader(title: "Recent Sleep")

                            ForEach(sleepEntries) { entry in
                                SleepHistoryRow(entry: entry)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Sleep")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddSleep = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddSleep) {
                AddSleepView()
            }
        }
    }
}

struct AddSleepView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var bedtime = Calendar.current.date(byAdding: .hour, value: -8, to: Date()) ?? Date()
    @State private var wakeTime = Date()
    @State private var deepMinutes = 90
    @State private var remMinutes = 90
    @State private var quality = 4
    @State private var notes = ""
    @State private var errorMessage: String?

    private var adjustedWakeTime: Date {
        if wakeTime < bedtime {
            return Calendar.current.date(byAdding: .day, value: 1, to: wakeTime) ?? wakeTime
        }

        return wakeTime
    }

    private var totalMinutes: Int {
        Calendar.current.dateComponents([.minute], from: bedtime, to: adjustedWakeTime).minute ?? 0
    }

    private var canSave: Bool {
        totalMinutes > 0 && deepMinutes + remMinutes <= totalMinutes
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Schedule") {
                    DatePicker("Bedtime", selection: $bedtime, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("Wake Time", selection: $wakeTime, displayedComponents: [.date, .hourAndMinute])

                    LabeledContent("Total Sleep", value: SleepFormat.minutes(totalMinutes))
                }

                Section("Sleep Details") {
                    Stepper(value: $deepMinutes, in: 0...720, step: 5) {
                        LabeledContent("Deep Sleep", value: SleepFormat.minutes(deepMinutes))
                    }

                    Stepper(value: $remMinutes, in: 0...720, step: 5) {
                        LabeledContent("REM Sleep", value: SleepFormat.minutes(remMinutes))
                    }

                    Stepper(value: $quality, in: 1...5) {
                        LabeledContent("Quality", value: "\(quality)/5")
                    }
                }

                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                }

                if !canSave {
                    Section {
                        Text("Deep sleep and REM sleep must fit within the total sleep time.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("New Sleep")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveSleepEntry()
                    }
                    .disabled(!canSave)
                }
            }
            .alert("Could not save sleep", isPresented: hasSaveError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage ?? "Please try again.")
            }
        }
    }

    private var hasSaveError: Binding<Bool> {
        Binding(
            get: { errorMessage != nil },
            set: { isShowing in
                if !isShowing {
                    errorMessage = nil
                }
            }
        )
    }

    private func saveSleepEntry() {
        let entry = SleepEntry(
            bedtime: bedtime,
            wakeTime: adjustedWakeTime,
            totalMinutes: totalMinutes,
            deepMinutes: deepMinutes,
            remMinutes: remMinutes,
            quality: quality,
            notes: notes.trimmingCharacters(in: .whitespacesAndNewlines)
        )

        modelContext.insert(entry)

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            errorMessage = error.localizedDescription
        }
    }
}

struct SleepSummaryCard: View {
    let entry: SleepEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Last Night")

            HStack(spacing: 20) {
                SleepStat(label: "Total Sleep", value: SleepFormat.minutes(entry.totalMinutes), icon: "moon.fill", color: .indigo)
                SleepStat(label: "Deep Sleep", value: SleepFormat.minutes(entry.deepMinutes), icon: "zzz", color: .purple)
                SleepStat(label: "REM Sleep", value: SleepFormat.minutes(entry.remMinutes), icon: "waveform", color: .cyan)
            }

            SleepStageBar(entry: entry)

            HStack {
                Label("\(entry.quality)/5", systemImage: "star.fill")
                    .foregroundColor(.yellow)

                Spacer()

                Text(entry.wakeTime, style: .date)
                    .foregroundColor(.secondary)
            }
            .font(.caption.weight(.semibold))
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

struct SleepEmptyState: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "bed.double.fill")
                .font(.system(size: 42))
                .foregroundColor(.indigo)

            Text("No sleep logged yet")
                .font(.headline)

            Text("Tap the plus button to register your first sleep entry.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

struct SleepHistoryRow: View {
    let entry: SleepEntry

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "moon.zzz.fill")
                .font(.title3)
                .foregroundColor(.indigo)
                .frame(width: 44, height: 44)
                .background(Color.indigo.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.wakeTime, style: .date)
                    .font(.subheadline.weight(.semibold))

                Text("\(entry.bedtime.formatted(date: .omitted, time: .shortened)) - \(entry.wakeTime.formatted(date: .omitted, time: .shortened))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(SleepFormat.minutes(entry.totalMinutes))
                    .font(.subheadline.weight(.semibold))

                Text("Quality \(entry.quality)/5")
                    .font(.caption)
                    .foregroundColor(.yellow)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

struct SleepStat: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
            Text(value)
                .font(.subheadline.bold())
            Text(label)
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}

struct SleepStageBar: View {
    let entry: SleepEntry

    private var coreMinutes: Int {
        max(entry.totalMinutes - entry.deepMinutes - entry.remMinutes, 0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sleep Stages")
                .font(.caption.weight(.semibold))
                .foregroundColor(.secondary)

            GeometryReader { geo in
                HStack(spacing: 2) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.indigo)
                        .frame(width: width(for: coreMinutes, totalWidth: geo.size.width))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.purple)
                        .frame(width: width(for: entry.deepMinutes, totalWidth: geo.size.width))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.cyan)
                        .frame(width: width(for: entry.remMinutes, totalWidth: geo.size.width))
                }
                .frame(height: 20)
            }
            .frame(height: 20)

            HStack {
                LegendDot(color: .indigo, label: "Core")
                LegendDot(color: .purple, label: "Deep")
                LegendDot(color: .cyan, label: "REM")
            }
        }
    }

    private func width(for minutes: Int, totalWidth: CGFloat) -> CGFloat {
        guard entry.totalMinutes > 0 else { return 0 }
        return totalWidth * CGFloat(minutes) / CGFloat(entry.totalMinutes)
    }
}

enum SleepFormat {
    static func minutes(_ minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60

        if hours == 0 {
            return "\(remainingMinutes)m"
        }

        if remainingMinutes == 0 {
            return "\(hours)h"
        }

        return "\(hours)h \(remainingMinutes)m"
    }
}

#Preview {
    SleepView()
        .modelContainer(for: SleepEntry.self, inMemory: true)
}
