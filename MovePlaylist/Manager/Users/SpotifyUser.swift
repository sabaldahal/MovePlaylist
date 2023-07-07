//
//  SpotifyUser.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/29/23.
//

import Foundation

class SpotifyUser{
    
    init(authorizationCode:String){
        self.authorizationCode = authorizationCode
    }
    
    init(authorizationCode:String, accessToken:AccessToken){
        self.authorizationCode = authorizationCode
        self.accessToken = accessToken
    }
    
    var isConnected:Bool {
        if authorizationCode != nil || authorizationCode != "" {
            return true
        }
        else {
            return false
        }
    }
    var authorizationCode:String?
    var accessToken:AccessToken?
    var cachedToken:AccessToken?

    
    func tokenHasExpired() -> Bool{
        guard let expirationDate = self.accessToken?.dateAdded else {
            return true
        }
        let now = Date().addingTimeInterval(TimeInterval(300))
        return now >= expirationDate
    }
    
    func cacheToken(){
        self.cachedToken = self.accessToken
    }
    
    func recoverCachedToken(){
        self.accessToken?.refresh_token = self.cachedToken!.refresh_token
    }
        
}
