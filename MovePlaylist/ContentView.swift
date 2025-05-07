//
//  ContentView.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(SourceDestination())
            .environmentObject(AuthenticationViewModel())
    }
}
