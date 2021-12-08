//
//  ImageService.swift
//  AlbumSeeker
//
//  Created by user on 08.12.2021.
//

import UIKit

class ImageService {
    
    static let shared = ImageService()
    private var imageCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func image(forURLString urlString: String, completion: @escaping (UIImage?) -> () ){
        
        // If there is a cached image then passing it to closure and returning nil dataTask
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            
        } else {
            // Fetching image from server and saving it to cache
            guard let url = URL(string: urlString) else { return }
            
            NetworkService.shared.fetchRequestFor(url: url) {[weak self] result in
                switch result {
                case .failure:
                    completion(nil)
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    self?.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                }
            }
        }
    }
}
