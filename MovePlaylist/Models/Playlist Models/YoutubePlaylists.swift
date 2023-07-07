//
//  YoutubePlaylists.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/26/23.
//

import Foundation

struct YoutubePlaylists: Decodable{
    var next:String?
    var items: [YTPlaylist] = [YTPlaylist]()

    
    enum MainKeys: String, CodingKey {
        case items
        case nextPageToken
    }
    
    init(from decoder: Decoder) throws {
        if let mainContainer = try? decoder.container(keyedBy: MainKeys.self){
            self.next = try? mainContainer.decode(String.self, forKey: .nextPageToken)
            self.items = try mainContainer.decode([YTPlaylist].self, forKey: .items)
        }
    }
}




struct YTPlaylist: Playlist, Decodable, Hashable{
    var id:String
    var title:String
    var thumbnail:URL?
    
    
    init(from decoder: Decoder) throws {
        let itemContainer = try decoder.container(keyedBy: ItemKeys.self)
            self.id = try itemContainer.decode(String.self, forKey: .id)
        let snippetContainer = try itemContainer.nestedContainer(keyedBy: SnippetKeys.self, forKey: .snippet)
            self.title = try snippetContainer.decode(String.self, forKey: .title)
        let thumbnailsContainer = try snippetContainer.nestedContainer(keyedBy: ThumbnailsKeys.self, forKey: .thumbnails)
        if let standardthumbnailContainer = try? thumbnailsContainer.nestedContainer(keyedBy: StandardThumbnailKeys.self, forKey: .standard){
            self.thumbnail = try standardthumbnailContainer.decode(URL.self, forKey: .url)
        }else if let highThumbnailContainer = try? thumbnailsContainer.nestedContainer(keyedBy: StandardThumbnailKeys.self, forKey: .high){
            self.thumbnail = try highThumbnailContainer.decode(URL.self, forKey: .url)
        }else{
            if let defaultThumbnailContainer = try? thumbnailsContainer.nestedContainer(keyedBy: StandardThumbnailKeys.self, forKey: .default){
                self.thumbnail = try? defaultThumbnailContainer.decode(URL.self, forKey: .url)
            }
        }
            
    }
    
    init(_ id:String, _ title:String, _ thumbnail:URL){
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
    
}

extension YTPlaylist{

    enum ItemKeys: String, CodingKey{
        case id
        case snippet
    }
    
    enum SnippetKeys: String, CodingKey{
        case title
        case thumbnails
    }
    enum ThumbnailsKeys: String, CodingKey{
        case standard
        case high
        case `default`
    }
    enum StandardThumbnailKeys: String, CodingKey{
        case url
    }
}
