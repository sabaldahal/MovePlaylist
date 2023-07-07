//
//  KeyChainHelper.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 6/28/23.
//

import Foundation

//saves user information securely
final class KeyChainHelper{
    
    static let standard = KeyChainHelper()
    private init(){}
    
      func save(_ data: Data, service: String, account:String){
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            print("Error: \(status)")
        }
        
        if status == errSecDuplicateItem {
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let attrToUpdate = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, attrToUpdate)
        }
    }

      func read(service: String, account: String) -> Data?{
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }
    
    func delete(service: String, account: String){
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        
        do {
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
            
        } catch {
            assertionFailure("Could not encode the item for keychain: \(error)")
        }
    }
    
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Could not decode the item for keychain: \(error)")
            return nil
        }
    }
}

