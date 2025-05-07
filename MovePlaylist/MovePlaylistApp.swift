//
//  MovePlaylistApp.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/12/23.
//

import SwiftUI
import GoogleSignIn

@main
struct MovePlaylistApp: App {
    @StateObject var srcdest = SourceDestination()
    @StateObject var authViewModel = AuthenticationViewModel()
    @StateObject var dataVM = DataViewModel()
    @StateObject var test = Testy()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(srcdest)
                .environmentObject(authViewModel)
                .environmentObject(dataVM)
                .environmentObject(test)
            
                .onAppear{
                    //restore previously saved logins
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        if user != nil {
                            self.authViewModel.musicServicesState.youtube = .signedIn
                        } else if let error = error{
                            self.authViewModel.musicServicesState.youtube = .signedOut
                            print(error)
                        } else{
                            self.authViewModel.musicServicesState.youtube = .signedOut
                        }
                    }
                    SpotifyManager.shared.restorePreviousSignIn { success in
                        if success {
                            self.authViewModel.musicServicesState.spotify = .signedIn
                        } else {
                            self.authViewModel.musicServicesState.spotify = .signedOut
                        }
                    }
                }
        }
    }
}
