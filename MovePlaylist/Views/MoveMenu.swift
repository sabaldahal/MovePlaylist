//
//  MoveMenu.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/14/23.
//

import SwiftUI
import GoogleSignInSwift

struct MoveMenu: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var authViewModel:AuthenticationViewModel
    @ObservedObject var srcdest:SourceDestination
    @Binding var showWebView:Bool
    @Binding var movingFromSource:Bool

    var body: some View {
        NavigationView{
                VStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 40){
                            ForEach(MusicServices.allCases, id: \.self){ musicService in
                                GeometryReader{ geo in
                                    LogoHolder(image: musicService.rawValue)
                                        .scaleEffect(
                                            withAnimation(.spring()){
                                                return decreaseBy(geo.frame(in: .global).minX, geo.frame(in: .global).maxX)
                                            }
                                        )
                                        .opacity(decreaseBy(geo.frame(in: .global).minX, geo.frame(in: .global).maxX))
                                        .onTapGesture {
                                            if movingFromSource{
                                                srcdest.source = musicService
                                            }else{
                                                srcdest.destination = musicService
                                            }
                                            if(authViewModel.getStateOf(type: musicService) == .signedOut){
                                                dismiss()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                    if (musicService == .spotify){
                                                        showWebView.toggle()
                                                    }
                                                    //case for youtube
                                                    else{
                                                        authViewModel.authenticator.authenticate(musicService: musicService)
                                                    }
                                                }
                                            }
                                            dismiss()
                                        }
                                }.frame(width: 100, height: 100)
                                
                            }
                        }
                        .padding(40)

                    }
                }

            //returns back to the home view
            .navigationBarItems(trailing: Button{
                dismiss()
            } label:{
                Text(Image(systemName: "xmark"))
                    .bold()
            })
            .navigationBarTitle(Text("Move From"), displayMode: .inline)

            
        }
        .preferredColorScheme(.light)
    }
}

struct MoveMenu_Previews: PreviewProvider {
    static var previews: some View {
        MoveMenu(authViewModel: AuthenticationViewModel(), srcdest: SourceDestination(), showWebView: .constant(false), movingFromSource: .constant(false))
            .preferredColorScheme(.dark)
    }
}

extension MoveMenu{
    
    func decreaseBy(_ minX:CGFloat, _ maxX:CGFloat) -> Double{
        if(minX > 0 && maxX < UIScreen.main.bounds.width){
            return 1
        }
        if (minX < 5){
            return (1 + (minX/200))
        }

        return (1 - ((maxX - UIScreen.main.bounds.width)/200))
    }
}
