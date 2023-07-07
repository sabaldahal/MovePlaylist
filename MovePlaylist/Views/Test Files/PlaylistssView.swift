//
//  PlaylistsView.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/27/23.
//

import SwiftUI

struct PlaylistssView: View {
    var allPlaylists:[YTPlaylist]? = YoutubeManager.shared.allplaylists?.items
    var emptylist:[YTPlaylist] = []
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(allPlaylists ?? emptylist, id: \.self){ playlist in
                            PlaylistCardView(pl: playlist)
                        
                        }
                    }

                }
            }
            .ignoresSafeArea()
        }
    }
}

struct PlaylistssView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistssView()
    }
}

