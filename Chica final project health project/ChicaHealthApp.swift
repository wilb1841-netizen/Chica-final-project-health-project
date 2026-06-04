
import SwiftUI

@main
struct Chica_final_project_health_projectApp: App {
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        }
    }
}
