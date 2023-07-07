//
//  HomeView.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/13/23.
//

import SwiftUI

struct HomeView: View {
    @State private var startMoving = false
    @State private var authSuccess:Bool = false
    @State private var isPresentWebView:Bool = false
    @EnvironmentObject var srcdest:SourceDestination
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
            VStack{
                if srcdest.source == nil {
                    Spacer()
                    AddTaskCircle(image: "wallpaper3")
                    Spacer()
                    Button {
                        startMoving.toggle()
                    } label: {
                        Text("Start Moving")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 60)
                            .background(.gray)
                            .cornerRadius(12)
                    }.offset(y: 0)
                    Spacer()
                    
                //display options for the music services
                    .sheet(isPresented: $startMoving){
                        MoveMenu(authViewModel: authViewModel, srcdest: srcdest, showWebView: $isPresentWebView, movingFromSource: .constant(true))
                            .presentationDetents([.fraction(0.35)])
                    }
                //open up web view for spotify to log in
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
                }else {
                    NavigationStack{
                        MoveTarget()
        
                    }
                   
                }

        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SourceDestination())
            .environmentObject(AuthenticationViewModel())

    }
}
