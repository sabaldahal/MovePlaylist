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
    var loadNextStatus = LoadStatus.ready
    
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

extension DataViewModel{
    
    func loadMorePlaylists(){
        
    }
    
    func loadMorePlaylistItems(currentItem: AnyPlaylist, type:MusicServices?){
        guard let type = type else{
            return
        }
        if !shouldLoadMorePlaylistItems(currentItem: currentItem){
            return
        }
        self.loadNextStatus = .loading
        
    }
    
    func shouldLoadMorePlaylistItems(currentItem: AnyPlaylist) -> Bool{
        if sourcePlaylistItems == nil || sourcePlaylistItems!.count < 20 {return false}
        for n in (sourcePlaylistItems!.count - 10) ... (sourcePlaylistItems!.count - 1){
            if n  > 0 && currentItem.id == sourcePlaylistItems![n].id{
                return true
            }
        }
        return false
    }
}

extension DataViewModel{
    enum LoadStatus {
        case ready
        case loading
        case error
        case done
    }
}
