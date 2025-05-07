//
//  ConnectedServices.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/17/23.
//

import SwiftUI

struct ConnectedServices: View {
    @EnvironmentObject var authViewModel:AuthenticationViewModel
    @State var expand:Bool = false
    var musicService:MusicServices
    var body: some View {
        VStack{
            HStack{
                Image(getLogo())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                Spacer()
                Button {
                    self.expand.toggle()
                } label: {
                    Image(systemName: self.expand ? "chevron.up" : "chevron.down")
                        .font(.largeTitle)
                }
                
                
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.gray)
            if self.expand {
                HStack{
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Disconnect")
                    }

                    
                }
                .padding()
            }
        }
        .animation(.spring(), value: self.expand)
        .alignmentGuide(VerticalAlignment.center){ $0[.top] }
        
    }
}

struct ConnectedServices_Previews: PreviewProvider {
    static var previews: some View {
        ConnectedServices(musicService: .spotify)
            .environmentObject(AuthenticationViewModel())
    }
}

extension ConnectedServices{
    func getLogo() -> String {
        switch self.musicService{
        case .spotify:
            return "spotifyfull"
        case .youtube:
            return "youtubefull"
        default:
            return ""
        }
    }
}
