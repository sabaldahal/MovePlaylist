//
//  YoutubeManager.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/19/23.
//

import Foundation
import GoogleSignIn

class YoutubeManager{
    var allplaylists:YoutubePlaylists?
    var playlistScopes = "https://www.googleapis.com/auth/youtube.readonly"
    
    init(){
    if let user = GIDSignIn.sharedInstance.currentUser{
        self.state = .signedIn(user)
    }else{
        self.state = .signedOut
    }
}
    
    static let shared = YoutubeManager()
    var authenticator = YoutubeAuthenticator()
    var state:GoogleSignInState
    func signIn(completion: @escaping((Bool) -> Void)){
#if os(iOS)
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let firstWindow = firstScene.windows.first else {
            return
        }

        guard let viewController = firstWindow.rootViewController else{
            print("no root view controller")
            return
        }
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController, hint: nil, additionalScopes: [playlistScopes]){ signInResult, error in
            guard let signInResult = signInResult else{
                print("Error! \(String(describing: error))")
                completion(false)
                return
            }
            self.state = .signedIn(signInResult.user)
            completion(true)
        }
        
#endif
    }
    
    private func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.state = .signedOut
    }
    
    func disconnect(){
        GIDSignIn.sharedInstance.disconnect{
            error in
            if let error = error {
                print("Encountered error disconnecting scope: \(error)")
            }
            self.signOut()
        }
    }
}


extension YoutubeManager{
    enum GoogleSignInState{
        case signedIn(GIDGoogleUser)
        case signedOut
    }
}
