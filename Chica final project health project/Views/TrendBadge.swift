//
//  TrendBadge.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI

struct TrendBadge: View {
    let trend: Double
    private var isPositive: Bool { trend >= 0 }

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: isPositive ? "arrow.up.right" : "arrow.down.right")
                .font(.system(size: 10, weight: .bold))
            Text(String(format: "%.1f%%", abs(trend)))
                .font(.system(size: 10, weight: .semibold))
        }
        .foregroundColor(isPositive ? .green : .red)
        .padding(.horizontal, 6)
        .padding(.vertical, 3)
        .background((isPositive ? Color.green : Color.red).opacity(0.12))
        .cornerRadius(6)
    }
}
