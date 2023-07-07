//
//  PlaylistItems.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/4/23.
//

import SwiftUI

struct PlaylistItems: View {
    @EnvironmentObject var dataVM:DataViewModel
    @EnvironmentObject var srcdest:SourceDestination
    var playlist:AnyPlaylist
    var body: some View {
        VStack{
            List(dataVM.sourcePlaylistItems ?? []){playlistItem in
                PlaylistRow(playlist: playlistItem)
            }
        }
        .navigationTitle(playlist.title)
        .onAppear{
            dataVM.fetchPlaylistItems(srcdest.source!, id: playlist.id)
        }
    }
}

struct PlaylistItems_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistItems(playlist: AnyPlaylist("1", "Sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!))
            .environmentObject(DataViewModel())
            .environmentObject(SourceDestination())
    }
}
