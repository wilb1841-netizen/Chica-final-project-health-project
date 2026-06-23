//
//  SleepEntry.swift
//  Chica final project health project
//
//  Created by Codex on 6/23/26.
//

import Foundation
import SwiftData

@Model
final class SleepEntry: Identifiable {
    var id: UUID
    var bedtime: Date
    var wakeTime: Date
    var totalMinutes: Int
    var deepMinutes: Int
    var remMinutes: Int
    var quality: Int
    var notes: String

    init(
        id: UUID = UUID(),
        bedtime: Date,
        wakeTime: Date,
        totalMinutes: Int,
        deepMinutes: Int,
        remMinutes: Int,
        quality: Int,
        notes: String = ""
    ) {
        self.id = id
        self.bedtime = bedtime
        self.wakeTime = wakeTime
        self.totalMinutes = totalMinutes
        self.deepMinutes = deepMinutes
        self.remMinutes = remMinutes
        self.quality = quality
        self.notes = notes
    }
}
