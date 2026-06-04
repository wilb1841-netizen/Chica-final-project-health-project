//
//  UserNotification.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/3/26.
//

import UIKit
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    // Singleton (shared instance on all usages)
    static let shared = NotificationManager()
    
    override private init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    // 1. Request Permission
    func requestPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted!")
            } else {
                print("Permission denied.")
            }
        }
    }

    // 2. Schedule Local Notification
    func scheduleLocalNotification() {
        // Create the content
        let content = UNMutableNotificationContent()
        content.title = "Time to Study!"
        content.body = "Open the app to review your Swift notes."
        content.sound = .default

        // Create the trigger (e.g., in 10 seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        

        // Create the request
        let request = UNNotificationRequest(identifier: "studyReminder", content: content, trigger: trigger)

        // Add request to the notification center
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification:\(error.localizedDescription)")
            } else {
                print("Local notification scheduled!")
            }
        }
    }
    // hook this to a test button/toolbar item
    func testNotification() {
        print("Starting Local PN test")
        let notifManager = NotificationManager.shared
        notifManager.requestPermission()
        notifManager.scheduleLocalNotification()
    }
    
    
//    // Create the trigger (e.g., in 10 seconds)
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//
//
//    // Create a trigger for a specific date and time (e.g., Oct 31 at 8:30 AM)
//    var dateComponents = DateComponents()
//    func dateComponents.month = 10
//    dateComponents.day = 31
//    dateComponents.hour = 8
//    dateComponents.minute = 30
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//

    // uncomment if you want the notification to be visible while the user is in the app
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }

}
