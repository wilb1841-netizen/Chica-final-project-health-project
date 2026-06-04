//
//  WorkoutRow.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI


struct WorkoutRow: View {
    let workout: WorkoutEntry

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: workout.icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 44, height: 44)
                .background(Color.blue.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 2) {
                Text(workout.name)
                    .font(.subheadline.weight(.semibold))
                Text(workout.date, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(workout.duration) min")
                    .font(.subheadline.weight(.semibold))
                Text("\(workout.calories) kcal")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}
