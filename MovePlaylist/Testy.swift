//
//  Testy.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/3/23.
//

import Foundation

class Testy: ObservableObject{
    init(){}
    static var shared = Testy()
    var y = 22
    @Published var data:[AnyPlaylist] = [
                   AnyPlaylist("1", "sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("2", "5080", URL(string: "https://i.ytimg.com/vi/hl9sSQhlqCU/sddefault.jpg")!),
                   AnyPlaylist("3", "khaled", URL(string: "https://i.ytimg.com/vi/JRFVPry3CHs/sddefault.jpg")!),
                   AnyPlaylist("4", "sample", URL(string: "https://i.ytimg.com/vi/QLliZzOgyIM/sddefault.jpg")!),
                   AnyPlaylist("5", "5080", URL(string: "https://i.ytimg.com/vi/obkrMiyDrbs/sddefault.jpg")!),
                   AnyPlaylist("6", "khaled", URL(string: "https://i.ytimg.com/vi/wocc6hwL4bU/sddefault.jpg")!),
                   AnyPlaylist("7", "sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("8", "5080", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("9", "khaled", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("11", "sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("12", "5080", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("13", "khaled", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("14", "sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("15", "5080", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("16", "khaled", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("17", "sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("18", "5080", URL(string: "https://i.ytimg.com/vi/DSMneXn238o/sddefault.jpg")!),
                   AnyPlaylist("19", "khaled", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("20", "sample", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("21", "5080", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!),
                   AnyPlaylist("22", "khaled", URL(string: "https://i.ytimg.com/vi/-_IspRG548E/maxresdefault.jpg")!)
        ]
    
}
