//
//  PlaylistsView.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/3/23.
//

import SwiftUI

struct PlaylistsView: View {
    @EnvironmentObject var srcdest:SourceDestination
    @EnvironmentObject var dataVM:DataViewModel
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            VStack{
                
                List(searchResults) { playlist in
                    
                    
                    NavigationLink(destination: PlaylistItems(playlist: playlist)) {
                        PlaylistRow(playlist: playlist)
                    }
                    
                }
                
            }
            .navigationTitle(Text("Playlists"))
            
            .searchable(text: $searchText, prompt: "Search Playlist")
            
        }
    }
}

struct PlaylistsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistsView()
            .environmentObject(SourceDestination())
            .environmentObject(DataViewModel())
            .preferredColorScheme(.dark)
    }
}

extension PlaylistsView{
    var searchResults:[AnyPlaylist] {
        guard let data = dataVM.sourceData else{
            return []
        }
        if searchText.isEmpty{
            return data
        } else{
            return data.filter{ $0.title.lowercased().contains(searchText.lowercased())}
        }
    }
}


