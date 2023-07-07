//
//  AuthenticationViewModel.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/29/23.
//

import Foundation
import GoogleSignIn

@MainActor
class AuthenticationViewModel: ObservableObject{
    
    init(){
        
        self.musicServicesState = MusicServicesState()
        //youtube
        if GIDSignIn.sharedInstance.currentUser != nil {
            musicServicesState.youtube = .signedIn
        }else{
            musicServicesState.youtube = .signedOut
        }
        //spotify
        if SpotifyManager.shared.user != nil{
            musicServicesState.spotify = .signedIn
        }else{
            musicServicesState.spotify = .signedOut
        }
        
    }
    
    @Published var musicServicesState:MusicServicesState
    var authenticator = AuthenticationHandler()
    
    func getStateOf(type:MusicServices) -> SignInState{
        switch type{
        case .spotify:
            return self.musicServicesState.spotify
        case .youtube:
            return self.musicServicesState.youtube
        default:
            return .signedOut
        }
    }
    
}




