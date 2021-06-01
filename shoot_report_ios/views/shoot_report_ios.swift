import SwiftUI
import Firebase

@main
struct shoot_report_iosApp: App {
    
    let persistenceController = PersistenceController.shared
    
    init() {
        // Initialize firebase
        FirebaseApp.configure()
        
        // Deactivate firebase analytics
        Analytics.setAnalyticsCollectionEnabled(false)
    }
    
    var body: some Scene {
        WindowGroup {
            WeaponList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .onAppear{sleep(3)}
        }
    }
}
