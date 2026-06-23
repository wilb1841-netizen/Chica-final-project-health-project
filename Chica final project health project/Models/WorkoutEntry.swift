//
//  Untitled.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 5/30/26.


import Foundation
import SwiftData

@Model
final class WorkoutEntry: Identifiable {
    var id: UUID
    var name: String
    var type: String
    var duration: Int
    var calories: Int
    var date: Date
    var icon: String
    var notes: String

    init(
        id: UUID = UUID(),
        name: String,
        type: String = "",
        duration: Int,
        calories: Int,
        date: Date,
        icon: String,
        notes: String = ""
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.duration = duration
        self.calories = calories
        self.date = date
        self.icon = icon
        self.notes = notes
    }
}
