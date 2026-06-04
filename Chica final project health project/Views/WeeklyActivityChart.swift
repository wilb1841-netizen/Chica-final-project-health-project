//
//  WeeklyActivityChart.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI



struct WeeklyActivityChart: View {
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let steps: [Double] = [6200, 8500, 5100, 9200, 8342, 3400, 7800]
    private let maxSteps: Double = 10000

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Weekly Steps")

            HStack(alignment: .bottom, spacing: 8) {
                ForEach(Array(zip(days, steps)), id: \.0) { day, count in
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(count >= maxSteps ? Color.green : Color.blue)
                            .frame(height: max(4, CGFloat(count / maxSteps) * 100))
                        Text(day)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(height: 130)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
        }
    }
}
