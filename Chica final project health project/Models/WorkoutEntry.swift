//
//  Untitled.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 5/30/26.


import SwiftUI

struct WorkoutEntry: Identifiable {
    let id = UUID()
    let name: String
    let duration: Int
    let calories: Int
    let date: Date
    let icon: String
}
