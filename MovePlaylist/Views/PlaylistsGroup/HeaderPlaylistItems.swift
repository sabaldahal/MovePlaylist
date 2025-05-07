//
//  HeaderPlaylistItems.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/7/23.
//

import SwiftUI

struct HeaderPlaylistItems: View {
    var sw = UIScreen.main.bounds.width/3
    var body: some View {
        VStack{
            HStack( spacing: 4){
                ForEach(0...1, id: \.self){
                    idx in
                    AsyncImage(url: Testy.shared.data[idx].thumbnail){ image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: {
                                idx == 1 ? sw*2:sw
                            }(), height: sw)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            HStack{
                ForEach(2...4, id: \.self){
                    idx in
                    AsyncImage(url: Testy.shared.data[idx].thumbnail){ image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: {
                                sw
                            }(), height: sw)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            HStack{
                ForEach(5...6, id: \.self){
                    idx in
                    AsyncImage(url: Testy.shared.data[idx].thumbnail){ image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: {
                                idx == 5 ? sw*2:sw
                            }(), height: sw)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
        
}

struct HeaderPlaylistItems_Previews: PreviewProvider {
    static var previews: some View {
        HeaderPlaylistItems()
    }
}

extension HeaderPlaylistItems{
    
}
