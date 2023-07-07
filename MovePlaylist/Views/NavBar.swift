//
//  NavBar.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/12/23.
//

import SwiftUI

struct NavBar: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        TabView(){
            HomeView()
                .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            googletest()
                .tabItem{
                Label("Google", systemImage: "gear")
            }
            SpotifyTest()
                .tabItem{
                Label("Spotify", systemImage: "gear")
            }
        }.accentColor(.orange)
            .onAppear{
                UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
            }
            .ignoresSafeArea()
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
            .preferredColorScheme(.dark)
            .environmentObject(SourceDestination())
            .environmentObject(AuthenticationViewModel())
    }
}
