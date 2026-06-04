//
//  NutritionView.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI

struct NutritionView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image(systemName: "fork.knife.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.secondary.opacity(0.5))
                Text("Nutrition tracking coming soon")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Nutrition")
        }
    }
}
