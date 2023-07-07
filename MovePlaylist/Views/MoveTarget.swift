//
//  MoveTarget.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/1/23.
//

import SwiftUI

struct MoveTarget: View {
    @EnvironmentObject var dataVM:DataViewModel
    @EnvironmentObject var srcdest:SourceDestination
    @EnvironmentObject var authViewModel:AuthenticationViewModel
    @State var isPresentWebView = false
    @State var changeTarget = false
    @State var authSuccess = false
    @State var movingFromSource = true
    @State var showPlaylists = false
    var body: some View {
        NavigationStack{
            NavigationLink(destination: PlaylistsView(), isActive: $showPlaylists)
            {}
            VStack{
                Spacer()
                if let source = srcdest.source{
                        ServiceSelectionRow(image: source.rawValue)
                            .onTapGesture {
                                movingFromSource = true
                                changeTarget.toggle()
                            }
                    Button("Show Playlists"){
                        dataVM.fetchPlaylists(source)
                        self.showPlaylists.toggle()
                    }
                        
                        
                }
                Spacer()


                ServiceSelectionRow(image: srcdest.destination?.rawValue)
                                .onTapGesture {
                                    movingFromSource = false
                                    changeTarget.toggle()
                                }
                
                Spacer()
            }
            .sheet(isPresented: $changeTarget){
                MoveMenu(authViewModel: authViewModel, srcdest: srcdest, showWebView: $isPresentWebView, movingFromSource: $movingFromSource)
                    .presentationDetents([.fraction(0.35)])
            }
            .sheet(isPresented: $isPresentWebView,
                   onDismiss: {
                if(authSuccess){
                    authViewModel.authenticator.authenticate(musicService: .spotify)
                }
            }){
                NavigationStack{
                    UserLoginView(authSuccess: $authSuccess, signInURL: SpotifyManager.shared.signInURL!)
                }
            }
        }

    }
}

struct MoveTarget_Previews: PreviewProvider {
    static var previews: some View {
        MoveTarget()
            .environmentObject(SourceDestination(.spotify, .youtube))
            .environmentObject(AuthenticationViewModel())
            .environmentObject(DataViewModel())
    }
}
