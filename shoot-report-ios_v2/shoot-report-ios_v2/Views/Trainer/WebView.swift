//
//  WebView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 09.04.21.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    
    let link: String

    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request: URLRequest = URLRequest(url: URL(string: link)!)
        uiView.load(request)
    }
    
}


struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(link: "https://www.apple.com")
    }
}
