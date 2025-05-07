//
//  PlaylistItems.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/4/23.
//

import SwiftUI

struct PlaylistItems: View {
    @EnvironmentObject var test:Testy
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dataVM:DataViewModel
    @EnvironmentObject var srcdest:SourceDestination
    @State var allSelected:Bool = false
    var playlist:AnyPlaylist
    var body: some View {
        VStack{

                ScrollView(){
               
                    ParallaxHeader(
                        coordinateSpace: CoordinateSpace.scrollView,
                        defaultHeight: 350
                    ) {
                        HeaderPlaylistItems()
                            .scaleEffect(1.2)
                            .rotation3DEffect(.degrees(20), axis: (x:1, y:-1, z:1))
                            .offset(x: -40, y: 0)
                            //.opacity(0.7)
                        
                    }
                    
                    ZStack(alignment: .topLeading){
                        VStack{
                            ForEach((test.data)){ playlistItem in
                                PlaylistItemsRow(playlist: playlistItem)
                                Divider()
                            }
                        }
                        .background()
                        GeometryReader{ v in
                            VStack{
                                Spacer()
                                HStack(spacing:20){
                                    Button {
                                        
                                    } label: {
                                        Text("Select By Genres")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(.black)
                                            .cornerRadius(20)
                                            .padding()
                                    }
                                    Spacer()
                                    Button {
                                        if allSelected {
                                            for idx in (0..<(test.data.count)){
                                                test.data[idx].isSelected = false
                                            
                                            }
                                        }
                                        else{
                                            for idx in (0..<(test.data.count)){
                                                test.data[idx].isSelected = true
                                            
                                            }
                                        }
                                        allSelected.toggle()
                                        
                                    } label: {
                                        Text(allSelected ? "Deselect All" : "Select All")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(.black)
                                            .cornerRadius(20)
                                            .padding()
                                    }
                                    
                                }
                            }
                            .frame(width: v.size.width, height: getHeightForMenu(proxy: v))
                            .background(getBackgroundColor(proxy: v))
                            .offset(y: getOffsetForMenu(proxy: v))
                            
                        }
                    }
                    
                }
                .coordinateSpace(name: CoordinateSpace.scrollView)
                .edgesIgnoringSafeArea(.top)
            
                    
            
            //.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
//            .listStyle(PlainListStyle())
            //.scrollContentBackground(.hidden)
//            .environment(\.defaultMinListHeaderHeight, 0)

                //.shadow(color: .black.opacity(0.8), radius: 10, y: -10)


        }
        .toolbarBackground(.hidden, for: .navigationBar)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: Button(action: {
//            dismiss()
//        }, label: {
//            Image(systemName: "arrow.left")
//        }))
        

        //.navigationTitle(playlist.title)
        .onAppear{
            //dataVM.fetchPlaylistItems(srcdest.source!, id: playlist.id)
        }
    }
}

struct PlaylistItems_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistItems(playlist: AnyPlaylist("1", "Sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!))
            .environmentObject(DataViewModel())
            .environmentObject(SourceDestination())
            .environmentObject(Testy())
            .preferredColorScheme(.dark)
    }
}

extension PlaylistItems{
    private enum CoordinateSpace{
        case scrollView
        case list
    }
    
    func getOffsetForMenu(proxy:GeometryProxy) -> CGFloat{
        let frame = proxy.frame(in: .named(CoordinateSpace.scrollView))
        return -frame.minY
    }
    
    func getHeightForMenu(proxy: GeometryProxy) -> CGFloat{
        let frame = proxy.frame(in: .named(CoordinateSpace.scrollView))
        return max(160, frame.minY)
    }
    
    func getBackgroundColor(proxy: GeometryProxy) -> Color {
        let frame = proxy.frame(in: .named(CoordinateSpace.scrollView))
        let value = (1 - max(0, min(1, (frame.minY - 200) / 350)))
        
        return Color.gray.opacity(value)
    }
}


