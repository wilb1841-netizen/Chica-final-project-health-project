//
//  HealthMetric 2.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 5/30/26.
//

import Foundation
import SwiftUI



enum TrendDirection {
    case up, down, stable
}

// Or a richer trend type:
struct Trend {
    let value: Double
    let direction: TrendDirection
    let period: String // e.g. "vs last week"
}

struct HealthMetric: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let unit: String
    let icon: String
    let color: Color
    let trend: Double?
}
