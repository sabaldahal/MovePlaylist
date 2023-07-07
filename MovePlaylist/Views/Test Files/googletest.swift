//
//  googletest.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/26/23.
//
import Combine
import SwiftUI
import GoogleSignInSwift

struct googletest: View {
    @State var showlists = false
    var body: some View {
        NavigationView{
            Button(action: {
                
            }, label: {Text("sign in does nothing here")})
            //GoogleSignInButton(action: YoutubeManager.shared.signIn{success in})
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(NSLocalizedString("fetch", comment: "fetchplaylists button"), action: fetchPlaylists)
                        Button(NSLocalizedString("disconnet", comment: "fetchplaylists button"), action: disconnect)
                        Button(NSLocalizedString("showlists", comment: "showlists button"), action: {
                            showlists.toggle()
                        })
                        
                    }
                    
                }
                .sheet(isPresented: $showlists){
                    PlaylistssView()
                }
            
        }
    }
}
    
    struct googletest_Previews: PreviewProvider {
        static var previews: some View {
            googletest()
        }
    }
    
extension googletest{
    func fetchPlaylists(){
        let authenticator = YoutubeAuthenticator()
        if(!authenticator.hasScope()){
            authenticator.addScopes {
            }
        }else{
            authenticator.playlistsPublisher { success, data in
                }

        }
    }

    func disconnect(){
        YoutubeManager.shared.disconnect()
    }
}


