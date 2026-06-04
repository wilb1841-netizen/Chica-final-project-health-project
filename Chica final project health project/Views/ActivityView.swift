//
//  ActivityView.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var vm: HealthTrackerViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Weekly summary bar chart (placeholder)
                    WeeklyActivityChart()
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "All Workouts")
                        ForEach(vm.workouts) { workout in
                            WorkoutRow(workout: workout)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Activity")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
