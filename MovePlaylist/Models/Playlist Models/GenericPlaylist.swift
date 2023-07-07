//
//  GenericPlaylist.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/3/23.
//

import Foundation
import UIKit


protocol Playlist: Identifiable{
    var id:String {get set}
    var title:String {get set}
    var thumbnail:URL? {get set}

}


struct AnyPlaylist: Identifiable, Hashable{
    let id:String
    let title:String
    let thumbnail:URL?
    
    init(_ playlist: any Playlist){
        self.id = playlist.id
        self.title = playlist.title
        self.thumbnail = playlist.thumbnail
    }
    
    init(_ id:String, _ title:String, _ thumbnail:URL){
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
    
    
}

