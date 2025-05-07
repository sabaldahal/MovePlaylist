//
//  TryTRyTry.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/10/23.
//

import SwiftUI


struct DetailView: View {
    @EnvironmentObject var dataVM:DataViewModel
    var body: some View {
        GeometryReader { v in
            ScrollView {
                ZStack(alignment: .topLeading) {
                    VStack {
                        ForEach(Testy.shared.data){ playlistItem in
                            PlaylistItemsRow(playlist: playlistItem)
                            Divider()
                        }
                    }.background(.white)
                    .offset(x: 0, y: v.size.height * 0.3)
                    GeometryReader { g in
                        ZStack(alignment: .bottomLeading) {
                            Image("wallpaper1")
                                .resizable()
                                .aspectRatio(1.6, contentMode: .fill)
                                
                                .edgesIgnoringSafeArea(.all)
                                .frame(width: v.size.width)
                                .blur(
                                    radius: 16 * (1 - max(0, min(1, (g.frame(in: .global).minY +  v.size.height * 0.3) / (v.size.height * 0.3)))),
                                    opaque: true
                                )
                            VStack(alignment: .leading) {
                                Text("Hello World")
                                    .font(.largeTitle)
                                    .padding()
                                    .background(.gray)
                                Text("Mountain!")
                                    .font(.headline)
                                    .foregroundColor(Color.secondary)
                            }
                            .padding()
                        }
                        .layoutPriority(100)
                        .frame(width: v.size.width, height: max(80,  v.size.height * 0.3 + g.frame(in: .global).minY))
                        .offset(x: 0, y: getoffsetty(proxy: g))
                    }
                    .frame(width: v.size.width, height: v.size.height * 0.3)
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(DataViewModel())
    }
}

func getoffsetty(proxy:GeometryProxy) -> CGFloat{
   return -proxy.frame(in: .global).minY
}
