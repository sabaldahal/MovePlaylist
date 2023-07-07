//
//  YoutubeAuthenticator.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/26/23.
//

import Foundation
import GoogleSignIn
import Combine

class YoutubeAuthenticator{
    var playlistScopes = "https://www.googleapis.com/auth/youtube.readonly"
    private let baseURLPlaylists = "https://www.googleapis.com/youtube/v3/playlists"
    private let baseURLPlaylistItem = "https://www.googleapis.com/youtube/v3/playlistItems"

    func hasScope() -> Bool{
        if let user = GIDSignIn.sharedInstance.currentUser{
            guard let scopes = user.grantedScopes else{
                return false
            }
            return scopes.contains(self.playlistScopes)
        }
        return false
    }
    
    func addScopes(completion: @escaping () -> Void){
        
        guard let currentUser = GIDSignIn.sharedInstance.currentUser else{
            print("no user signed in")
            return
        }
        
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let firstWindow = firstScene.windows.first else {
            return
        }

        guard let viewController = firstWindow.rootViewController else{
            print("no root view controller")
            return
        }
        
        currentUser.addScopes([playlistScopes], presenting: viewController) { signInResult, error in
            if let error = error {
                print("found error while adding scope: \(error)")
                return
            }
            guard signInResult != nil else { return}
            completion()
        }
    }
    
    private func sessionWithFreshToken(completion: @escaping (Result<URLSession, Error>) -> Void){
        GIDSignIn.sharedInstance.currentUser?.refreshTokensIfNeeded { user, error in
            guard let token = user?.accessToken.tokenString else{
                completion(.failure(.couldNotCreateURLSession(error)))
                return
            }
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = [
                "Authorization": "Bearer \(token)"
            ]
            let session = URLSession(configuration: configuration)
            completion(.success(session))
            
        }
    }
    
    func playlistsPublisher(completion: @escaping (Bool, YoutubePlaylists?) -> Void){
        sessionWithFreshToken{ result in
            switch result{
            case .success(let authSession):
                var components:URLComponents?{
                    var comps = URLComponents(string: self.baseURLPlaylists)
                    comps?.queryItems = [
                        URLQueryItem(name: "part", value: "snippet"),
                        URLQueryItem(name: "maxResults", value: "50"),
                        URLQueryItem(name: "mine", value: "true")
                    ]
                    return comps
                }
                var request:URLRequest?{
                    guard let components = components, let url = components.url else{
                        return nil
                    }
                    return URLRequest(url: url)
                }
                guard var request = request else{
                    return completion(false, nil)
                }
                request.httpMethod = "GET"
                let task = authSession.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        completion(false, nil)
                        return
                    }
                    do {
                        let playlistResult = try JSONDecoder().decode(YoutubePlaylists.self, from: data)
                        completion(true, playlistResult)
                        
                    }
                    catch {
                        print(error)
                        completion(false, nil)
                    }
                }
                task.resume()

            case .failure(let error):
                print(error)
                completion(false, nil)
            }
            
        }
    }
    
    func fetchPlaylistItems(id:String, completion: @escaping (Bool, YoutubePlaylists?) -> Void){
        sessionWithFreshToken{ result in
            switch result{
            case .success(let authSession):
                var components:URLComponents?{
                    var comps = URLComponents(string: self.baseURLPlaylistItem)
                    comps?.queryItems = [
                        URLQueryItem(name: "part", value: "snippet"),
                        URLQueryItem(name: "maxResults", value: "50"),
                        URLQueryItem(name: "playlistId", value: id)
                    ]
                    return comps
                }
                var request:URLRequest?{
                    guard let components = components, let url = components.url else{
                        return nil
                    }
                    return URLRequest(url: url)
                }
                guard var request = request else{
                    return completion(false, nil)
                }
                request.httpMethod = "GET"
                let task = authSession.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        completion(false, nil)
                        return
                    }
                    do {
                        let playlistResult = try JSONDecoder().decode(YoutubePlaylists.self, from: data)
                        
                        completion(true, playlistResult)
                        
                    }
                    catch {
                        print(error)
                        completion(false, nil)
                    }
                }
                task.resume()

            case .failure(let error):
                print(error)
                completion(false, nil)
            }
            
        }
    }
}

extension YoutubeAuthenticator{
    enum Error: Swift.Error {
        case couldNotCreateURLSession(Swift.Error?)
        case couldNotCreateURLRequest
        case userHasNoPlaylists
        case couldNotFetchPlaylists
    }
}
