//
//  spotifyplaylistcardview.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/30/23.
//

import SwiftUI

struct spotifyplaylistcardview: View {
    var pl:AnyPlaylist
    
    let fw:Double = 250
    let fh:Double = 300
    let ih:Double = 225
    var body: some View {
        ZStack{
            Color(.black)
            .opacity(0.2)
            VStack{
                    AsyncImage(url: pl.thumbnail){image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: fw, height:ih)
                    }placeholder: {
                        Color.black
                    }

                
                Spacer()
                VStack{
                    Text(pl.title)
                    Text(pl.id)
                }
                Spacer()
                
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 80))
        .frame(width:fw, height: fh)
    }
}

struct spotifyplaylistcardview_Previews: PreviewProvider {
    static var previews: some View {
        spotifyplaylistcardview(pl: AnyPlaylist("1", "Sample Playlist", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!))
    }
}
