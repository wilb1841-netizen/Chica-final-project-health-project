

import SwiftUI

struct DashboardView: View {
    @ObservedObject var vm: HealthTrackerViewModel
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Greeting header
                    VStack(alignment: .leading, spacing: 4) {
                        Text(vm.greeting)
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Text("Here's your health today")
                            .font(.largeTitle.bold())
                    }
                    .padding(.horizontal)

                    // Daily goals ring section
                    DailyGoalsSection(goals: vm.dailyGoals)

                    // Metrics grid
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Today's Metrics")
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(vm.metrics) { metric in
                                MetricCard(metric: metric)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Recent workouts
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Recent Workouts")
                        ForEach(vm.workouts.prefix(3)) { workout in
                            WorkoutRow(workout: workout)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { vm.loadData() }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }
}
      
