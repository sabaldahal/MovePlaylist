//
//  SpotifyAuthenticator.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/5/23.
//

import Foundation

class SpotifyAuthenticator{
    init(){}
    
    var service = "access-token-details"
    var account = "spotify-for-move-playlists"
    var authservice = "authcode"
    let baseURLPlaylists = "https://api.spotify.com/v1/me/playlists"
    let baseURLPlaylistItems = ""

    func getAccessToken(baseURL:String, authCode:String, redirectURI: String, clientId:String, clientSecret:String, completion: @escaping ((Bool, AccessToken?) -> Void)) {
        let baseURL = URL(string: baseURL)
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: authCode),
            URLQueryItem(name: "redirect_uri", value: redirectURI)
        ]
        var request = URLRequest(url: baseURL!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = clientId+":"+clientSecret
        let encodedData = basicToken.data(using: .utf8)
        guard let base64String = encodedData?.base64EncodedString() else{
            completion(false, nil)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        var token: AccessToken?
        let task = URLSession.shared.dataTask(with: request) { data, request, error in
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            do {
                token = try JSONDecoder().decode(AccessToken.self, from: data)
                completion(true, token)
                
            }
            catch {
                completion(false, nil)
            }
        }
        task.resume()
        return
    }
           
    func Authenticate(){
        guard let authCode = SpotifyManager.shared.user?.authorizationCode else{
        print("No authorization Code provided for authentication")
        return
    }
        getAccessToken(baseURL: SpotifyManager.Constants.AUTHENTICATE_BASE_URL, authCode: authCode, redirectURI: SpotifyManager.Constants.REDIRECT_URI, clientId: SpotifyManager.Constants.CLIENT_ID, clientSecret: SpotifyManager.Constants.CLIENT_SECRET){
        success, token in
        if success {
            SpotifyManager.shared.user?.accessToken = token
            self.saveTokenToKeyChain(token!)
        }
    }
}
    
    func requestRefreshToken(completion: @escaping((Bool, AccessToken?) -> Void)){
        guard let refresh_token = SpotifyManager.shared.user?.accessToken?.refresh_token else{
            print("No authorization Code provided for authentication")
            return
        }
        let baseURL = URL(string: SpotifyManager.Constants.AUTHENTICATE_BASE_URL)
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refresh_token),
        ]
        var request = URLRequest(url: baseURL!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        let basicToken = SpotifyManager.Constants.CLIENT_ID+":"+SpotifyManager.Constants.CLIENT_SECRET
        let encodedData = basicToken.data(using: .utf8)
        guard let base64String = encodedData?.base64EncodedString() else{
            completion(false, nil)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        var token: AccessToken?
        let task = URLSession.shared.dataTask(with: request) { data, request, error in
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            do {
                token = try JSONDecoder().decode(AccessToken.self, from: data)
                completion(true, token)
                
            }
            catch {
                completion(false, nil)
            }
        }
        task.resume()
        return
    }
            
    func restorePreviousSignIn(completion: @escaping (Bool) -> Void){
        let authCode = self.loadAuthCodeFromKeyChain()
        if authCode == nil {
            completion(false)
            return
        }
        let token = self.loadTokenFromKeyChain()
        guard let token = token else{
            completion(false)
            return
        }
        SpotifyManager.shared.user = SpotifyUser(authorizationCode: authCode!, accessToken: token)
        completion(true)
        return
    }
    
    func saveAuthCodeToKeyChain(_ data:String){
        let encodedData = Data(data.utf8)
        KeyChainHelper.standard.save(encodedData, service: self.authservice, account: self.account)
    }
        
    func saveTokenToKeyChain(_ data:AccessToken){
        KeyChainHelper.standard.save(data,service: self.service, account: self.account)
    }
    
    func loadAuthCodeFromKeyChain() -> String?{
        let data = KeyChainHelper.standard.read(service: self.authservice, account: self.account)
        if let data = data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func loadTokenFromKeyChain() -> AccessToken?{
        return KeyChainHelper.standard.read(service: self.service, account: self.account, type: AccessToken.self)
        
    }
    
    func deleteAllFromKeyChain(){
        KeyChainHelper.standard.delete(service: self.service, account: self.account)
        KeyChainHelper.standard.delete(service: self.authservice, account: self.account)
    }
    
    func sessionWithFreshToken(completion: @escaping((Bool) -> Void)){
        guard let user = SpotifyManager.shared.user else {
            completion(false)
            return
        }
        if user.tokenHasExpired(){
            self.requestRefreshToken { success, data in
                if success {
                    SpotifyManager.shared.user?.cacheToken()
                    SpotifyManager.shared.user?.accessToken = data
                    SpotifyManager.shared.user?.recoverCachedToken()
                    self.saveTokenToKeyChain(SpotifyManager.shared.user!.accessToken!)
                    completion(true)
                    return
                }else{
                    completion(false)
                    return
                }
                
            }
        }
        completion(true)
    }
    
    func fetchProfile(){
        let baseURL = URL(string: "https://api.spotify.com/v1/me")
        var request = URLRequest(url: baseURL!)
        request.httpMethod = "GET"
        guard let access_token = SpotifyManager.shared.user?.accessToken?.access_token else{
            return
        }
        
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request){ data, response, errortr in
            guard let data = data, errortr == nil else{
                return
            }
            do{
                let jsonData = try JSONDecoder().decode(UserProfile.self, from: data)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
    func fetchPlaylists(completion: @escaping((Bool, SpotifyPlaylists?)->Void)){
        sessionWithFreshToken { success in
            if success {
                let baseURL = self.baseURLPlaylists
                var components = URLComponents(string: baseURL)!
                components.queryItems = [
                    URLQueryItem(name: "limit", value: "2")
                ]
                var request = URLRequest(url: components.url!)
                request.httpMethod = "GET"
                guard let access_token = SpotifyManager.shared.user?.accessToken?.access_token else{
                    completion(false, nil)
                    return
                }
                request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request){ data, response, errortr in
                    guard let data = data, errortr == nil else{
                        completion(false, nil)
                        return
                    }
                    do{
                        var jsonData: SpotifyPlaylists? = try JSONDecoder().decode(SpotifyPlaylists.self, from: data)
                        completion(true, jsonData)
                        
                    }
                    catch{
                        print(error)
                    }
                }
                task.resume()
            }
        }
    }
    
    private func getRequest(urlString:String?) -> URLRequest?{
        guard let urlString = urlString else {
            return nil
        }
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "50")
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        return request
    }
    
     func fetchNextPlaylist(urlString:String) async throws -> SpotifyPlaylists?{
        //no need to refresh token as it will be excuted consecutively with the other fetch functions
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        guard let access_token = SpotifyManager.shared.user?.accessToken?.access_token else{
            return nil
        }
        request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        var result = try JSONDecoder().decode(SpotifyPlaylists.self, from: data)
        if (result.next != nil){
            await result.items.append(contentsOf: (try self.fetchNextPlaylist(urlString: result.next!)?.items)!)
        }
        return result
    }
    
    func fetchPlaylistItems(id:String, completion: @escaping((Bool, SpotifyPlaylistItems?)->Void)){
        sessionWithFreshToken { success in
            if success {
                let baseURL = "https://api.spotify.com/v1/playlists/\(id)/tracks"
                var request = self.getRequest(urlString: baseURL)
                guard let access_token = SpotifyManager.shared.user?.accessToken?.access_token, var request = request else{
                    completion(false, nil)
                    return
                }
                request.setValue("Bearer \(access_token)", forHTTPHeaderField: "Authorization")
                let task = URLSession.shared.dataTask(with: request){ data, response, errortr in
                    guard let data = data, errortr == nil else{
                        completion(false, nil)
                        return
                    }
                    do{
                        let jsonData = try JSONDecoder().decode(SpotifyPlaylistItems.self, from: data)
                        completion(true, jsonData)
                        
                    }
                    catch{
                        print(error)
                    }
                }
                task.resume()
            }
        }
    }
    
}
