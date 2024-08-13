//
//  AideView.swift
//  Placks
//
//  Created by Julien Heinen on 14/07/2024.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct AideView: View {
    var body: some View {
        WebView(url: URL(string: "https://vegetalsearch.alwaysdata.net/API/support.html")!)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) // Ajustez ces valeurs selon vos besoins
            .navigationTitle("Aide")
    }
}

struct AideView_Previews: PreviewProvider {
    static var previews: some View {
        AideView()
    }
}
