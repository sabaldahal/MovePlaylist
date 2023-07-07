//
//  AddTaskCircle.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/13/23.
//

import SwiftUI

struct AddTaskCircle: View {
    var image:String

    var body: some View {
        
         VStack{
                 Image(image)
                    .resizable()
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.white, lineWidth: 5)
                    }
                    .shadow(color: .white, radius: 12)
                    .frame(width: 250, height: 250)
        }
         
    }
}

struct AddTaskCircle_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskCircle(image: "spotify")
    }
}

