//
//  SpotifyTest.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/30/23.
//

import SwiftUI

struct SpotifyTest: View {
    @State var showlists = false
    var body: some View {
        NavigationView{
            Button(action: {}, label: {
                Text("Does nothing")
            })
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(NSLocalizedString("fetchPlaylists", comment: "fetchplaylists button"), action: fetchPlaylists)
                        Button(NSLocalizedString("fetchProfile", comment: "fetchplaylists button"), action: fetchProfile)
                        Button(NSLocalizedString("disconnet", comment: "fetchplaylists button"), action: disconnect)
                        Button(NSLocalizedString("showlists", comment: "showlists button"), action: {
                            showlists.toggle()
                        })
                        
                    }
                    
                }
                .sheet(isPresented: $showlists){
                    spotifyplaylistsview()
                }
            
        }
    }
}

struct SpotifyTest_Previews: PreviewProvider {
    static var previews: some View {
        SpotifyTest()
    }
}
extension SpotifyTest{
    func fetchPlaylists(){
        SpotifyManager.shared.authenticator.fetchPlaylists { didComplete, data in
            if didComplete{
                SpotifyManager.shared.allPlaylists = data
            }
        }
        
    }
    
    func fetchProfile(){
        SpotifyManager.shared.authenticator.fetchProfile()
    }

    func disconnect(){
        SpotifyManager.shared.removeUser()
    }

}
