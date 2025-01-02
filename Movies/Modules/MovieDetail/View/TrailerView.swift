//
//  MovieTrailerView.swift
//  Movies
//
//  Created by Ma'sum on 01/01/25.
//

import SwiftUI
import WebKit

struct TrailerView: UIViewRepresentable {
    let videoId: String
    let autoplay: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.configuration.allowsInlineMediaPlayback = true
        webView.configuration.mediaTypesRequiringUserActionForPlayback = []
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let autoplayParam = autoplay ? "1" : "0"
        
        guard let url = URL(string: "https://www.imdb.com/video/embed/\(videoId)/?autoplay=\(autoplayParam)&width=1020") else {
            return
        }
        
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct TrailerPlayerView_Preview: PreviewProvider {
    static var previews: some View {
        TrailerView(
            videoId: "cGzBscTnuc0",
            autoplay: true
        )
    }
}
