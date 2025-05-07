//
//  MusicServices.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/24/23.
//

import Foundation

//work in progress
//remove if necessary
enum MusicServices: String, CaseIterable{
    case spotify
    case youtube
    case applemusic
    case amazonmusic
}

class MusicServicesState{
    
    init(){
        spotify = .signedOut
        youtube = .signedOut
    }
    var spotify:SignInState
    var youtube:SignInState
}

enum SignInState{
    case signedIn
    case signedOut
}
