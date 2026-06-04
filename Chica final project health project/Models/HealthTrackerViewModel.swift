//
//  HealthTrackerViewModel.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 5/30/26.
//

import SwiftUI
import Foundation

import SwiftUI
import Foundation
import Combine

 
@MainActor
class HealthTrackerViewModel: ObservableObject {
 
    // MARK: Published Properties
    @Published var metrics: [HealthMetric] = []
    @Published var workouts: [WorkoutEntry] = []
    @Published var dailyGoals: [DailyGoal] = []
    @Published var selectedTab: Tab = .dashboard
    @Published var isLoading: Bool = false
    @Published var greeting: String = ""
    @Published var errorMessage: String? = nil
 
    // MARK: - Tab Enum
    enum Tab: String, CaseIterable {
        case dashboard = "Dashboard"
        case activity  = "Activity"
        case nutrition = "Nutrition"
        case sleep     = "Sleep"
 
        var icon: String {
            switch self {
            case .dashboard: return "square.grid.2x2"
            case .activity:  return "figure.run"
            case .nutrition: return "fork.knife"
            case .sleep:     return "moon.zzz"
            }
        }
    }
 
    // MARK: - Init
    init() {
        updateGreeting()
        loadData()
    }
 
    // MARK: - Greeting
    func updateGreeting() {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12:  greeting = "Good morning"
        case 12..<17: greeting = "Good afternoon"
        default:      greeting = "Good evening"
        }
    }
 
    // MARK: - Load Data
    func loadData() {
        isLoading = true
        errorMessage = nil
 
        // Replace these with real HealthKit queries
        loadMetrics()
        loadWorkouts()
        loadDailyGoals()
 
        isLoading = false
    }
 
    // MARK: - Metrics
    private func loadMetrics() {
        metrics = [
            HealthMetric(
                title: "Heart Rate",
                value: "72",
                unit: "bpm",
                icon: "heart.fill",
                color: .red,
                trend: -2.1
            ),
            HealthMetric(
                title: "Steps",
                value: "10,000",
                unit: "steps",
                icon: "figure.walk",
                color: .blue,
                trend: 12.4
            ),
            HealthMetric(
                title: "Calories",
                value: "3,840",
                unit: "kcal",
                icon: "flame.fill",
                color: .orange,
                trend: 5.3
            ),
            HealthMetric(
                title: "Blood Oxygen",
                value: "98",
                unit: "%",
                icon: "lungs.fill",
                color: .cyan,
                trend: 0.5
            ),
            HealthMetric(
                title: "Active Minutes",
                value: "45",
                unit: "min",
                icon: "bolt.fill",
                color: .yellow,
                trend: 8.0
            ),
            HealthMetric(
                title: "HRV",
                value: "42",
                unit: "ms",
                icon: "waveform.path.ecg",
                color: .purple,
                trend: -3.2
            ),
        ]
    }
 
    // MARK: - Workouts
    private func loadWorkouts() {
        workouts = [
            WorkoutEntry(
                name: "Morning Run",
                duration: 32,
                calories: 320,
                date: Date().addingTimeInterval(-3600),
                icon: "figure.run"
            ),
            WorkoutEntry(
                name: "Weight Training",
                duration: 55,
                calories: 410,
                date: Date().addingTimeInterval(-90000),
                icon: "dumbbell"
            ),
            WorkoutEntry(
                name: "Yoga",
                duration: 45,
                calories: 180,
                date: Date().addingTimeInterval(-180000),
                icon: "figure.yoga"
            ),
            WorkoutEntry(
                name: "Cycling",
                duration: 60,
                calories: 520,
                date: Date().addingTimeInterval(-270000),
                icon: "bicycle"
            ),
        ]
    }
 
    // MARK: - Daily Goals
    private func loadDailyGoals() {
        dailyGoals = [
            DailyGoal(
                title: "Steps",
                current: 8342,
                target: 10000,
                unit: "steps",
                color: .blue
            ),
            DailyGoal(
                title: "Calories",
                current: 1840,
                target: 2200,
                unit: "kcal",
                color: .orange
            ),
            DailyGoal(
                title: "Water",
                current: 1.6,
                target: 2.5,
                unit: "L",
                color: .cyan
            ),
            DailyGoal(
                title: "Sleep",
                current: 7.2,
                target: 8.0,
                unit: "hrs",
                color: .indigo
            ),
        ]
    }
 
    // MARK: - Helpers
 
    /// Progress value 0.0 – 1.0 for a given goal
    func progress(for goal: DailyGoal) -> Double {
        min(goal.current / goal.target, 1.0)
    }
 
    /// Total calories burned across all workouts today
    var totalCaloriesToday: Int {
        workouts
            .filter { Calendar.current.isDateInToday($0.date) }
            .reduce(0) { $0 + $1.calories }
    }
 
    /// Total workout minutes today
    var totalActiveMinutesToday: Int {
        workouts
            .filter { Calendar.current.isDateInToday($0.date) }
            .reduce(0) { $0 + $1.duration }
    }
}
