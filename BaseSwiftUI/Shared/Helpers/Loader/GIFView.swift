//
//  GIFView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import SwiftUI
import WebKit

struct GIFView: UIViewRepresentable {
    let name: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = false
        
        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let data = try? Data(contentsOf: url) {
            webView.load(
                data,
                mimeType: "image/gif",
                characterEncodingName: "utf-8",
                baseURL: url.deletingLastPathComponent()
            )
        }
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }
}
