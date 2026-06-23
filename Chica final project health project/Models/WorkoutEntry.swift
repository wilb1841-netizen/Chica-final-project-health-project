//
//  Untitled.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 5/30/26.


import SwiftUI

struct WorkoutEntry: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let duration: Int
    let calories: Int
    let date: Date
    let icon: String
    let notes: String

    init(
        name: String,
        type: String = "",
        duration: Int,
        calories: Int,
        date: Date,
        icon: String,
        notes: String = ""
    ) {
        self.name = name
        self.type = type
        self.duration = duration
        self.calories = calories
        self.date = date
        self.icon = icon
        self.notes = notes
    }
}
