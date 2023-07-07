//
//  LogoHolder.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/24/23.
//

import SwiftUI

struct LogoHolder: View {
    var image:String
    var body: some View {
        VStack{
            Image(uiImage: UIImage(named: image) ?? UIImage(systemName: "plus.circle.fill")!)
                   .resizable()
                   .scaledToFit()
                   //.clipShape(Circle())
                   //.shadow(color: .white, radius: 12)
                   .frame(width: 100, height: 100)
                   //.background(.green)

       }
    }
}

struct LogoHolder_Previews: PreviewProvider {
    static var previews: some View {
        LogoHolder(image: "spotify")
    }
}


