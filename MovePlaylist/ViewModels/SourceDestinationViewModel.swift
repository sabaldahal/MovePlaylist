//
//  SourceDestinationController.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/19/23.
//

import Foundation

@MainActor
class SourceDestination: ObservableObject{
    @Published var source:MusicServices?
    @Published var destination:MusicServices?
    @Published var workingOn:MusicServices?
    
    init(){}
    init(_ source:MusicServices, _ destination:MusicServices){
        self.source = source
        self.destination = destination
    }
    init(_ source:MusicServices){
        self.source = source
    }

    

}

