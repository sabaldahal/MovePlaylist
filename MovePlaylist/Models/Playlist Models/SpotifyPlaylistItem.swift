//
//  SpotifyPlaylistItem.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/6/23.
//

import Foundation

//
//  SpotifyPlaylists.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/29/23.
//

import Foundation

struct SpotifyPlaylistItems: Decodable{
    var next:String?
    var items: [SPlaylistItem] = [SPlaylistItem]()

    
    enum MainKeys: String, CodingKey {
        case items
        case next
    }
    
    
    init(from decoder: Decoder) throws {
        if let mainContainer = try? decoder.container(keyedBy: MainKeys.self){
            self.next = try? mainContainer.decode(String.self, forKey: .next)
            self.items = try mainContainer.decode([SPlaylistItem].self, forKey: .items)
        }
    }
}

struct SPlaylistItem: Playlist, Decodable, Hashable{
    var id:String
    var title:String
    var thumbnail:URL?
    
    
    init(from decoder: Decoder) throws {
        let itemContainer = try decoder.container(keyedBy: ItemKeys.self)
        let track = try itemContainer.nestedContainer(keyedBy: TrackKeys.self, forKey: .track)
        if let album = try? track.nestedContainer(keyedBy: AlbumKeys.self, forKey: .album){
            let images = try album.decode([Images].self, forKey: .images)
            if images.count > 0 {
                self.thumbnail = images[0].url
            }
        }
        self.id = try track.decode(String.self, forKey: .id)
        self.title = try track.decode(String.self, forKey: .name)
            
    }
    
    init(_ id:String, _ title:String, _ thumbnail:URL){
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
    
}

extension SPlaylistItem{
    
    enum ItemKeys: String, CodingKey{
        case track
    }

    enum TrackKeys: String, CodingKey{
        case id
        case album
        case artists
        case name
    }
    
    enum AlbumKeys: String, CodingKey{
        case images
    }


}

