//
//  SpotifyPlaylists.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/29/23.
//

import Foundation

struct SpotifyPlaylists: Decodable{
    var next:String?
    var items: [SPlaylist] = [SPlaylist]()

    
    enum MainKeys: String, CodingKey {
        case items
        case next
    }
    
    init(from decoder: Decoder) throws {
        if let mainContainer = try? decoder.container(keyedBy: MainKeys.self){
            self.next = try? mainContainer.decode(String.self, forKey: .next)
            self.items = try mainContainer.decode([SPlaylist].self, forKey: .items)
        }
    }
}

struct SPlaylist: Playlist, Decodable, Hashable{
    var id:String
    var title:String
    var thumbnail:URL?
    
    
    init(from decoder: Decoder) throws {
        let itemContainer = try decoder.container(keyedBy: ItemKeys.self)
            self.id = try itemContainer.decode(String.self, forKey: .id)
            self.title = try itemContainer.decode(String.self, forKey: .name)
            let images = try itemContainer.decode([Images].self, forKey: .images)
        if images.count > 0 {
            self.thumbnail = images[0].url
        }
            
    }
    
    init(_ id:String, _ title:String, _ thumbnail:URL){
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
    
}

extension SPlaylist{

    enum ItemKeys: String, CodingKey{
        case id
        case images
        case name
    }


}
struct Images: Decodable, Hashable{
    var url:URL
    
    init(from decoder: Decoder) throws {
        let imageContainer = try decoder.container(keyedBy: ImageKeys.self)
        self.url = try imageContainer.decode(URL.self, forKey: .url)
    }
    
    enum ImageKeys: String, CodingKey{
        case url
    }
}
