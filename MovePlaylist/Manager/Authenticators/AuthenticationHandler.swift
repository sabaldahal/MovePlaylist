//
//  AuthenticationHandler.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/1/23.
//

import Foundation

class AuthenticationHandler{
    
    init(){}
    
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
        SpotifyManager.shared.authenticator.Authenticate()
    }
    
    func handleYoutubeAuthentication(){
        YoutubeManager.shared.signIn(){
            success in

        }

    }
    
}
