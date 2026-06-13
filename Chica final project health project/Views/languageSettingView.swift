//
//  languageSetting View.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/1/26.
//

import SwiftUI

struct LanguageSettingsView: View {
    @State private var selectedLanguage = "English"
    @AppStorage("loggedInUserId") private var loggedInUserId: String = ""

    let languages = [
        "English",
        "Spanish",
        "French",
        "German"
    ]

    var greeting: String {
        switch selectedLanguage {
        case "Spanish":
            return "Hola"
        case "French":
            return "Bonjour"
        case "German":
            return "Hallo"
        default:
            return "Hello"
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text(greeting)
                    .font(.largeTitle)

                Picker("Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.self) { language in
                        Text(language)
                    }
                }
                .pickerStyle(.menu)

                Text("Selected: \(selectedLanguage)")
            }
            .padding()
            .navigationTitle("Language Settings")
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    Button("Logout") {
                        loggedInUserId = ""
                    }
                }
            }
        }
    }
}

#Preview {
    LanguageSettingsView()
}
