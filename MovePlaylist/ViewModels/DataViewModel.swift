//
//  SourceDestinationController.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/25/23.
//

import Foundation

@MainActor
class DataViewModel: ObservableObject{
    
    init(){}
    @Published var sourceData:[AnyPlaylist]?
    @Published var sourcePlaylistItems:[AnyPlaylist]?
    
    func addToCache(url:URL?) async {
       guard let url = url else{
           return
       }
       ImageCache.shared.loadImageFromURL(url: url)
   }
    
    func fetchPlaylists(_ forType:MusicServices){
        self.sourceData = []
        switch forType{
        case .spotify:
            self.getSpotifyPlaylists()
            return
        case .youtube:
            self.getYoutubePlaylists()
            return
        default:
            return
        }
        
    }
    
    func fetchPlaylistItems(_ forType:MusicServices, id:String){
        self.sourcePlaylistItems = []
        switch forType{
        case .spotify:
            self.getSpotifyPlaylistItems(id)
            return
        case .youtube:
            self.getYoutubePlaylistItems(id)
            return
        default:
            return
        }
    }
    
    func getSpotifyPlaylists(){
        SpotifyManager.shared.authenticator.fetchPlaylists { didComplete, data in
                if didComplete{
                    DispatchQueue.main.async{
                        self.sourceData = data?.items.map{
                            return AnyPlaylist($0)
                        }
                    }
                }
            }
    }

    func getYoutubePlaylists(){
        if(!YoutubeManager.shared.authenticator.hasScope()){
            YoutubeManager.shared.authenticator.addScopes {
            }
        }else{
            YoutubeManager.shared.authenticator.playlistsPublisher { success, data in
                DispatchQueue.main.async{
                    self.sourceData = data?.items.map{
                        return AnyPlaylist($0)
                    }
                }
                }

        }
    }
    
    func getSpotifyPlaylistItems(_ id:String){
        SpotifyManager.shared.authenticator.fetchPlaylistItems(id: id) { didComplete, data in
                if didComplete{
                    DispatchQueue.main.async{
                        self.sourcePlaylistItems = data?.items.map{
                            return AnyPlaylist($0)
                        }
                    }
                }
            }
    }
    
    func getYoutubePlaylistItems(_ id:String){
        YoutubeManager.shared.authenticator.fetchPlaylistItems(id: id) { success, data in
            DispatchQueue.main.async{
                self.sourcePlaylistItems = data?.items.map{
                    return AnyPlaylist($0)
                }
            }
            }
    }
    
    
}
