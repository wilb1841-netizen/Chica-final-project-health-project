
import SwiftUI
import SwiftData

@main
struct Chica_final_project_health_projectApp: App {
    @AppStorage("loggedInUserId") private var loggedInUserId: String = ""
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome  = false
    
    
    var sharedModelContainer: ModelContainer = {

        let schema = Schema([
            User.self,
            WorkoutEntry.self,
            SleepEntry.self,
            
        ])

        do {
            let modelConfiguration = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: false
            )

            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Error setting up SwiftData: \(error)")
        }

    }()
    
    
    var body: some Scene {
        WindowGroup {
            if !loggedInUserId.isEmpty {
                MainView()
            } else if !hasSeenWelcome {
                WelcomeView()
            } else {
//                LoginView()
                WelcomeView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
