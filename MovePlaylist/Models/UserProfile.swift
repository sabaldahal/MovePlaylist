//
//  UserProfile.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/16/23.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
}

struct APIImage: Codable {
    let url: String
}
