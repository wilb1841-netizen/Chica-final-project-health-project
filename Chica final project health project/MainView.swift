import SwiftUI
import HealthKit
import Combine

struct MainView: View {
    @StateObject private var vm = HealthTrackerViewModel()
    
    
    
    
    var body: some View {
        TabView {
            
            DashboardView(vm: vm)
                .tabItem {
                    Label("Dashboard", systemImage: "heart.fill")
                }
            
            ActivityView(vm: vm)
                .tabItem {
                    Label("Activity", systemImage: "figure.walk")
                }
            
            SleepView()
                .tabItem {
                    Label("Sleep", systemImage: "bed.double.fill")
                }

            PaymentPlanView()
                .tabItem {
                    Label("Plan", systemImage: "creditcard.fill")
                }
            
            LanguageSettingsView()
                .tabItem {
                    Label("Language", systemImage: "globe")
                }
        }
    }
}


       

#Preview {
    MainView()
}
