//
//  PlaylistRow.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/3/23.
//

import SwiftUI

struct PlaylistRow: View {
    @EnvironmentObject var dataVM:DataViewModel
    var playlist: AnyPlaylist
    var body: some View {
        HStack(spacing: 50){
            VStack{
                if let image = (ImageCache.shared.get(forKey: playlist.thumbnail?.absoluteString)){
                    //Text("here")
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height:100)
                }
                else{
                    AsyncImage(url: playlist.thumbnail){image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height:100)
                    }placeholder: {
                        ProgressView()
                        //Color.black
                    }
                }
            }
            .frame(width:100, height:100)
            Text(playlist.title)
        }
        .onAppear{
            Task{
                await dataVM.addToCache(url: playlist.thumbnail)
            }
        }
            
    }
}

struct PlaylistRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistRow(playlist: AnyPlaylist("1", "Sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!))
            .environmentObject(DataViewModel())
    }
}
