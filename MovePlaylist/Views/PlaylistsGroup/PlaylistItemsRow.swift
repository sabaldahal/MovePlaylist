//
//  PlaylistItemsRow.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/10/23.
//

import SwiftUI

struct PlaylistItemsRow: View {
    @EnvironmentObject var dataVM:DataViewModel
    @EnvironmentObject var test:Testy
    var playlist: AnyPlaylist
    var body: some View {
        HStack(spacing: 40){
                if let image = (ImageCache.shared.get(forKey: playlist.thumbnail?.absoluteString)){
                    //Text("here")
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 133, height:100)
                        .clipped()
                }
                else{
                    AsyncImage(url: playlist.thumbnail){image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 133, height:100)
                            .clipped()
                    }placeholder: {
                        ProgressView()
                        //Color.black
                    }
                }
            
            
            Text(playlist.title)
            Spacer()
            Image(systemName: playlist.isSelected ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    var idx = test.data.firstIndex{$0.id == playlist.id}
                    test.data[idx!].isSelected.toggle()
                }
                .font(.title)
                .padding()
            
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .leading])
        
        .onAppear{
            Task{
                await dataVM.addToCache(url: playlist.thumbnail)
            }
        }
            
    }
}

struct PlaylistItemsRow_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistItemsRow(playlist: (AnyPlaylist("1", "Sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!)))
            .environmentObject(DataViewModel())
            .environmentObject(Testy())
    }
}

