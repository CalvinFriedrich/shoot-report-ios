import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Navigation Bar
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().tintColor = .white
        
        // Menu Bar
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "menuColor")
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                GeometryReader { geometry in
                    Color(backgroundColor ?? .white)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}
