//
//  WebView.swift
//  ScheduleTracker
//
//  Created by Василий Ханин on 25.06.2025.
//


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        if isDarkMode {
            let cssString = """
        * { background: #181A20 !important; color: #fff !important; border-color: #444 !important; box-shadow: none !important; }
        a { color: #89aaff !important; }
        """
            
            let jsString = """
        var style = document.createElement('style');
        style.innerHTML = `\(cssString)`;
        document.head.appendChild(style);
        """
            
            let userScript = WKUserScript(source: jsString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            configuration.userContentController.addUserScript(userScript)
        }
        let webView = WKWebView(frame: .zero, configuration: configuration)
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
