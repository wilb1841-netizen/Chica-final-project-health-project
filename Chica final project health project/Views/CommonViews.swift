//
//  Untitled.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI


struct LegendDot: View {
    let color: Color
    let label: String

    var body: some View {
        HStack(spacing: 4) {
            Circle().fill(color).frame(width: 8, height: 8)
            Text(label).font(.caption2).foregroundColor(.secondary)
        }
    }
}


struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.primary)
    }
}
