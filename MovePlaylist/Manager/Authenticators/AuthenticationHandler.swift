//
//  AuthenticationHandler.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/1/23.
//

import Foundation

class AuthenticationHandler{
    
    init(authViewModel: AuthenticationViewModel){
        self.authViewModel = authViewModel
    }
    
    var authViewModel:AuthenticationViewModel
    
    func authenticate(musicService: MusicServices){
        switch musicService{
        case .spotify:
            self.handleSpotifyAuthentication()
            return
        case .youtube:
            self.handleYoutubeAuthentication()
            return
        default:
            return
        }
    }
    
    func handleSpotifyAuthentication(){
        SpotifyManager.shared.authenticator.Authenticate(){ success in
            if success{
                self.authViewModel.musicServicesState.spotify = .signedIn
            }else{
                self.authViewModel.musicServicesState.spotify = .signedOut
            }
            
        }
    }
    
    func handleYoutubeAuthentication(){
        YoutubeManager.shared.signIn(){
            success in
            if success {

                self.authViewModel.musicServicesState.youtube = .signedIn
            }else{
                self.authViewModel.musicServicesState.youtube = .signedOut
            }
        }

    }
    
    
    
}
