//
//  AccessToken.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/19/23.
//

import Foundation

struct AccessToken: Codable{
    var access_token:String
    var token_type:String
    var scope:String
    var expires_in:Int
    var refresh_token:String
    var dateAdded:Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.access_token = try container.decode(String.self, forKey: .access_token)
        self.token_type = try container.decode(String.self, forKey: .token_type)
        self.scope = try container.decode(String.self, forKey: .scope)
        self.expires_in = try container.decode(Int.self, forKey: .expires_in)
        if let ref_token = try? container.decode(String.self, forKey: .refresh_token){
            self.refresh_token = ref_token
        }else{
            self.refresh_token = "na"
        }
        if let date = try? container.decode(Date.self, forKey: .dateAdded){
            self.dateAdded = date
        }else{
            self.dateAdded = Date().addingTimeInterval(TimeInterval(self.expires_in))
        }
    }
}

extension AccessToken{
    enum CodingKeys: String, CodingKey{
        case access_token
        case token_type
        case scope
        case expires_in
        case refresh_token
        case dateAdded
    }
}
