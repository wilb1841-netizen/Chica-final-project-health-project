//
//  Metric Card.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import Foundation
import SwiftUI

struct MetricCard: View {
    let metric: HealthMetric

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: metric.icon)
                    .font(.title3)
                    .foregroundColor(metric.color)
                Spacer()
                if let trend = metric.trend {
                    TrendBadge(trend: trend)
                }
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(metric.value)
                    .font(.title2.bold())
                    .foregroundColor(.primary)
                Text(metric.unit)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Text(metric.title)
                .font(.caption.weight(.semibold))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}
