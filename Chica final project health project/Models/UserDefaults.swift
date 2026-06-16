//
//  UserDefault.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/14/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("username") private var username = ""
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            Button("Save Username") {
                            UserDefaults.standard.set(username, forKey: "username")
                        }

                        Button("Load Username") {
                            username = UserDefaults.standard.string(forKey: "username") ?? ""
                        }

                        Button("Login") {
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            isLoggedIn = true
                        }

                        Button("Check Login Status") {
                            isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
                        }

                        Text("Saved User: \(username)")
                        Text(isLoggedIn ? "Logged In" : "Logged Out")
                    }
                    .padding()
            Toggle("Logged In", isOn: $isLoggedIn)

            Text("Saved User: \(username)")
        Text(isLoggedIn ? "Logged In" : "Logged Out")
            .foregroundColor(isLoggedIn ? .green: .red)
        }
        
    
    }


#Preview {
    ContentView()
}
