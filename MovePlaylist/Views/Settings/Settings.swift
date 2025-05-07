//
//  Settings.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/14/23.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        VStack{
            Text("Configurations")
            VStack{
                ConnectedServices(musicService: .spotify)
                ConnectedServices(musicService: .youtube)
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
