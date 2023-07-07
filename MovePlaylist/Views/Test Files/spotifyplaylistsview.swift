//
//  spotifyplaylistsview.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/30/23.
//

import SwiftUI

struct spotifyplaylistsview: View {
    @EnvironmentObject var dataVM: DataViewModel
    var allPlaylists:[SPlaylist]? = SpotifyManager.shared.allPlaylists?.items
    var emptylist:[AnyPlaylist] = []
    var body: some View {
        NavigationStack{
            ZStack{
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(dataVM.sourceData ?? emptylist, id: \.self){ playlist in
                            spotifyplaylistcardview(pl: playlist)
                        
                        }
                    }

                }
            }
            .ignoresSafeArea()
        }
    }
}

struct spotifyplaylistsview_Previews: PreviewProvider {
    static var previews: some View {
        spotifyplaylistsview()
            .environmentObject(DataViewModel())
    }
}
