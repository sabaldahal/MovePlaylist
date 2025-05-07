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
    var movingFromSource:Bool
    var body: some View {
        NavigationStack{
           // NavigationLink(destination: PlaylistsView(), isActive: $showPlaylists)
            //{}
            VStack{
                Spacer()
                switch movingFromSource{
                case true:
                    Text("Select Source")
                        .font(.title2)
                        .padding()
                    ServiceSelectionRow(image: srcdest.source?.rawValue)
                        .onTapGesture {
                            changeTarget.toggle()
                        }
                    Spacer()
                    NavigationLink {
                        MoveTarget(movingFromSource: false)
                    } label: {
                        Text("Select Destination")
                            .padding()
                            .padding(.horizontal, 25)
                            .background(.gray)
                            .cornerRadius(10)
                            .padding()
                    }
                default:
                    Text("Select Destination")
                        .font(.title2)
                        .padding()
                    ServiceSelectionRow(image: srcdest.destination?.rawValue)
                        .onTapGesture {
                            changeTarget.toggle()
                        }
                    Spacer()
                    NavigationLink {
                        PlaylistsView().onAppear{
                            dataVM.fetchPlaylists(srcdest.source!)
                        }
                    } label: {
                        Text("Select Playlists")
                            .padding()
                            .padding(.horizontal, 25)
                            .background(.gray)
                            .cornerRadius(10)
                            .padding()
                    }
                }


                Spacer()
            }
            .sheet(isPresented: $changeTarget){
                MoveMenu(authViewModel: authViewModel, srcdest: srcdest, showWebView: $isPresentWebView, movingFromSource: movingFromSource)
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
        MoveTarget(movingFromSource: true)
            .environmentObject(SourceDestination(.spotify, .youtube))
            .environmentObject(AuthenticationViewModel())
            .environmentObject(DataViewModel())
    }
}
