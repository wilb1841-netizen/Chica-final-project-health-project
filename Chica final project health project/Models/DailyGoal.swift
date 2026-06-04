//
//  DailyGoal.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 5/30/26.
//

import SwiftUI
import Combine


struct DailyGoal: Identifiable {
    let id = UUID()
    let title: String
    let current: Double
    let target: Double
    let unit: String
    let color: Color
}
