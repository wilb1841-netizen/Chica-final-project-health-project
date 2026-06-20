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
    var current: Double
    let target: Double
    let unit: String
    let color: Color

    var progress: Double {
        guard target > 0 else { return 0 }
        return min(current / target, 1.0)
    }

    var isComplete: Bool {
        current >= target
    }

    var remaining: Double {
        max(target - current, 0)
    }
}
