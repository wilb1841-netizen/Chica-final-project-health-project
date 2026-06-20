//
//  DailyGoalsSection.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//
import SwiftUI

struct DailyGoalsSection: View {
    let goals: [DailyGoal]
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Daily Goals")
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(goals) { goal in
                        GoalRingCard(goal: goal)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
