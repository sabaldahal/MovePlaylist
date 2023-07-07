//
//  SpotifyView.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/14/23.
//

import SwiftUI
import WebKit
import Combine

struct UserLoginView: UIViewRepresentable {

    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var srcdest:SourceDestination
    @Binding var authSuccess: Bool
    
    var signInURL:URL?
    
    func makeUIView(context: Context) -> WKWebView {
        //let preferences = WKWebpagePreferences()
        //preferences.allowsContentJavaScript = true
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        return wkWebView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context){
        let request = URLRequest(url: signInURL!)
        webView.load(request)

    }
    
    func makeCoordinator() -> WebViewCoordinator {
            WebViewCoordinator(self)
    }
    
    
    //detect url
    class WebViewCoordinator: NSObject, WKNavigationDelegate{
        var parentWebView: UserLoginView
        
        init(_ parentWebView: UserLoginView){
            self.parentWebView = parentWebView
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let urlToMatch = "sabaldahal.github.io"
            let url = navigationAction.request.url!
            let urlStr = url.absoluteString
            if url.host == urlToMatch {
                if let code = URLComponents(string: urlStr)?.queryItems?.first(where: {$0.name == "code"})?.value{
                    //
                    //if possible handle this logic from authViewModel
                    //
                    SpotifyManager.shared.createUser(authorizationCode: code)
                    parentWebView.authSuccess = true
                }
                else{
                    //AuthHandler.shared.authError = true
                    parentWebView.authSuccess = false
                }
                parentWebView.dismiss()
            }
            decisionHandler(.allow)

        }
    }
 }
    
    

struct UserLoginView_Previews: PreviewProvider {
    static var previews: some View {
        UserLoginView(authSuccess: .constant(false), signInURL: SpotifyManager.shared.signInURL)
            .environmentObject(SourceDestination())
    }
}
