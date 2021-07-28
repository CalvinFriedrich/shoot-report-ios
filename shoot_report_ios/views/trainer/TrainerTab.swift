import SwiftUI
import WebKit

struct TrainerTab: UIViewRepresentable {
    
    let request: String
    private let hostingUrl: String = "https://trainer.burkhardt-sport.solutions"
    private let validLocales: [String] = ["de", "en"]
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.navigationDelegate = context.coordinator
        let url = "\(hostingUrl)/\(getLocale())/\(request)"
        print(url)
        uiView.load(URLRequest(url: URL(string: url)!))
    }
    
    func getLocale() -> String {
        var locale: String = Locale.current.languageCode?.lowercased() ?? "en"
        if !validLocales.contains(locale) {
            locale = "en"
        }
        return locale
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }
            
            if (!url.absoluteString.contains("https://trainer.burkhardt-sport.solutions")) {
                decisionHandler(.cancel)
                UIApplication.shared.open(url)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}

struct TrainerTechnic_Previews: PreviewProvider {
    static var previews: some View {
        TrainerTab(request: "https://www.apple.com")
    }
}
