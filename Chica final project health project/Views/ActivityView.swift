//
//  ActivityView.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var vm: HealthTrackerViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // Weekly summary bar chart (placeholder)
                    WeeklyActivityChart()
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "All Workouts")
                        ForEach(vm.workouts) { workout in
                            WorkoutRow(workout: workout)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Activity")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}



/**
 Plan: be abel tomanually register activiries in the activityView
 
 create the view with the form for the user to provide the activity information that you may need
 when the user clicks on the + button from the toolbar, the view is presented in a sheet
 
 finish the functionality on the form view to save the new activity in swift data
 for this you will need:
 - make the WorkoutEntry a Swift data model
 - add the WorkoutEntry model to the swift data models list
 
 
 
 modify the source of the activitiy list in activityView to read from swift Data and display the records
 
 
 */
