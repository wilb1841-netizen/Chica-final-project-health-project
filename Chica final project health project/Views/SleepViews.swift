//
//  SleepViews.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI




// MARK: - Sleep Placeholder

struct SleepView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    SleepSummaryCard()
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Sleep")
        }
    }
}

struct SleepSummaryCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Last Night")

            HStack(spacing: 20) {
                SleepStat(label: "Total Sleep", value: "7h 12m", icon: "moon.fill", color: .indigo)
                SleepStat(label: "Deep Sleep",  value: "1h 45m", icon: "zzz",       color: .purple)
                SleepStat(label: "REM Sleep",   value: "1h 30m", icon: "waveform",  color: .cyan)
            }

            SleepStageBar()
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
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sleep Stages")
                .font(.caption.weight(.semibold))
                .foregroundColor(.secondary)

            GeometryReader { geo in
                HStack(spacing: 2) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: geo.size.width * 0.12)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.indigo)
                        .frame(width: geo.size.width * 0.24)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.purple)
                        .frame(width: geo.size.width * 0.20)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.cyan)
                        .frame(width: geo.size.width * 0.22)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.indigo.opacity(0.5))
                        .frame(width: geo.size.width * 0.22)
                }
                .frame(height: 20)
            }
            .frame(height: 20)

            HStack {
                LegendDot(color: .gray.opacity(0.5),   label: "Awake")
                LegendDot(color: .indigo,               label: "Core")
                LegendDot(color: .purple,               label: "Deep")
                LegendDot(color: .cyan,                 label: "REM")
            }
        }
    }
}

