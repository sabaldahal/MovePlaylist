//
//  ConnectAccount.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/14/23.
//

import SwiftUI

struct ConnectAccount: View {
    @State private var isPresentWebView = false
    @State private var authSuccess = false
    @State private var displaytext: String?
    var body: some View {
        VStack{
            Text(displaytext ?? "nothinghere")

            Button{
                displaytext = "empty"

            }label:{
                Text("print token")
            }
            Button("Open Webview"){
                isPresentWebView.toggle()
            }
            .sheet(isPresented: $isPresentWebView){
                NavigationStack{
                    UserLoginView(authSuccess: $authSuccess, signInURL: SpotifyManager.shared.signInURL!)
                        .ignoresSafeArea()
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            
        }

    }
}

struct ConnectAccount_Previews: PreviewProvider {
    static var previews: some View {
        ConnectAccount()
    }
}
