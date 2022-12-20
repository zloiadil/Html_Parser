//
//  ViewController.swift
//  HTMLParser
//
//  Created by Адиль Бектурсунов on 20.12.2022.
//

import WebKit
import UIKit

final class ViewController: UIViewController, WKNavigationDelegate {

    private let webView: WKWebView = {
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        let pagePrefs = WKWebpagePreferences()
        pagePrefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        config.defaultWebpagePreferences = pagePrefs
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let parser = HTMLParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://www.netflix.com/") else { return }
        view.addSubview(webView)
        webView.load (URLRequest(url:url))
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.innerHTML;") { [weak self] result, error in
            guard let html = result as? String, error == nil else {
                print("Failed to get HTML")
                return
            }
            
            self?.parser.parse(html: html)
            
        }
    }

}

