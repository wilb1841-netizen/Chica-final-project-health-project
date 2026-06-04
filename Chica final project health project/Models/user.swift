//
//  user.swift
//  Chica final project health project
//
//  Created by Wilbert Baker on 6/3/26.
//

import Foundation
import SwiftData
import CryptoKit
import SwiftUI
 
 
@Model
final class User: Identifiable {
    var id: UUID            // auto-generated
    var firstName: String
    var lastName: String
    var email: String
    var password: String    // hashed version
 
 
    init(firstName: String, lastName: String, email: String, password_text: String) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = User.hashPassword(password_text)
    }
 
    static func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
 

var sharedModelConteiner: ModelContainer = {
        
        let schema = Schema([
            User.self,
        ])
        
        do {
let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
          
          let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
          
          let context = container.mainContext
          
          return container
      }
      catch {
          fatalError("Error setting up SwiftData: \(error)")
      }
      
  }()
  
  @AppStorage("loggedInUserId") private var loggedInUserId: String = ""
