//
//  Testy.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/3/23.
//

import Foundation

class Testy{
    init(){}
    static var shared = Testy()
    
    var data:[AnyPlaylist] = {
        var pls = [SPlaylist("1", "sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                             SPlaylist("2", "5080", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   SPlaylist("3", "khaled", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!)
        ]
        var dataa = pls.map{AnyPlaylist($0)}
        return dataa
    }()
    
}
