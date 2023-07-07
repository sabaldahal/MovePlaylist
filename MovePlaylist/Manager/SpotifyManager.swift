//
//  SpotifyManager.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/19/23.
//

import Foundation

class SpotifyManager{
    
    init(){}
    
    static let shared = SpotifyManager()
    var user:SpotifyUser?
    var allPlaylists:SpotifyPlaylists?
    struct Constants{
        static let CLIENT_ID = "ff85821d32dd41c8bfe5b49dcb7e3b73"
        static let CLIENT_SECRET = "88527f92ad6c41e1985c8acba30334c4"
        static let REDIRECT_URI = "https://sabaldahal.github.io"
        static let AUTHORIZE_BASE_URL = "https://accounts.spotify.com/authorize?"
        static let AUTHENTICATE_BASE_URL = "https://accounts.spotify.com/api/token"
    }
    var signInURL: URL?{
    let scopes = "user-read-private%20user-read-email%20user-read-playback-state%20user-top-read%20playlist-read-private"
    let showDialog = "TRUE"
    let authURL = "\(Constants.AUTHORIZE_BASE_URL)response_type=code&client_id=\(Constants.CLIENT_ID)&scope=\(scopes)&redirect_uri=\(Constants.REDIRECT_URI)&show_dialog=\(showDialog)"
    return URL(string: authURL)
    }
    var authenticator = SpotifyAuthenticator()
           
    func restorePreviousSignIn(completion: @escaping (Bool) -> Void){
        let authCode = self.authenticator.loadAuthCodeFromKeyChain()
        if authCode == nil {
            completion(false)
            return
        }
        let token = self.authenticator.loadTokenFromKeyChain()
        guard let token = token else{
            completion(false)
            return
        }
        self.user = SpotifyUser(authorizationCode: authCode!, accessToken: token)
        completion(true)
        return
    }
    
    func createUser(authorizationCode:String){
        //create user and save authorization code to keychain
        self.user = SpotifyUser(authorizationCode: authorizationCode)
        self.authenticator.saveAuthCodeToKeyChain(authorizationCode)
    }
    
    func removeUser(){
        self.authenticator.deleteAllFromKeyChain()
        self.user = nil
    }
    
    func disconnect(){
        self.removeUser()
    }
}
