
import SwiftUI
import SwiftData

@main
struct Chica_final_project_health_projectApp: App {
    @AppStorage("loggedInUserId") private var loggedInUserId: String = ""
    
    
    var sharedModelContainer: ModelContainer = {

        let schema = Schema([
            User.self,
            WorkoutEntry.self,
            
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
            } else {
                LoginView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
