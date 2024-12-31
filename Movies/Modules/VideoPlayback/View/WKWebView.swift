//
//  VideoPlaybackView.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Nothing to update
    }
}

struct VideoPlaybackView: View {
    var videoURL: URL

    var body: some View {
        VStack {
            Text("Watch Video")
                .font(.title)
                .padding()

            WebView(url: videoURL)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
