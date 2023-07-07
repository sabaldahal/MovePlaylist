//
//  ImageCache.swift
//  MovePlaylist
//
//  Created by Sabal Dahal on 7/4/23.
//

import Foundation
import UIKit

class ImageCache{
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey:String?) -> UIImage? {
        guard let forKey = forKey else{
            return nil
        }
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey:String, image:UIImage){
        cache.setObject(image, forKey: NSString(string: forKey))
    }
    
    func loadImageFromURL(url:URL?){
        guard let url = url else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            guard let data = data else {
                print("No data found")
                return
            }
            
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
                self.set(forKey: url.absoluteString, image: loadedImage)
            }
        }
        task.resume()
    }
    
}

extension ImageCache{
    static var shared = ImageCache()
}

