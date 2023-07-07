//
//  ServiceSelectionRow.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/2/23.
//

import SwiftUI

struct ServiceSelectionRow: View {
    var image:String?
    @State var isAnimating = false
    var body: some View {
        HStack(spacing: 10){
            Text("Source")
                .padding(.horizontal, 20)
            Spacer()
            VStack{
                LogoHolder(image: image ?? "plus.circle.fill")
                    .frame(width: 150, height: 150)
                    .background(Color(white: 0.2))
                    .cornerRadius(20)
            }

            
                
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.gray)
        .cornerRadius(20)
        .padding()
        .offset(y: isAnimating ? 0 : 180)
        .animation(.easeIn(duration: 0.3), value: isAnimating)
        .onAppear{
            isAnimating = true
        }
    }
}

struct ServiceSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        ServiceSelectionRow()
    }
}
