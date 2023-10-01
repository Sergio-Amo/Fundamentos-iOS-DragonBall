//
//  UIImage+Remote.swift
//  DragonBall_practica-iOS
//
//  Created by Sergio Amo on 30/9/23.
//

import UIKit
// Use NSCache to cache images, and make it a singleton.
final class ImageLoadingWithCache {
    static let instance = ImageLoadingWithCache()
    var imageCache = NSCache<NSString, UIImage>()
    func loadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data, error == nil, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }.resume()
        }
    }
}

extension UIImageView {
    func setImage(for url: URL) {
        // Upgrade to https if possible
        let finalUrl: URL
        if url.scheme == "http" {
            finalUrl = url.upgradeUrl(url: url)
        } else {
            finalUrl = url
        }
        ImageLoadingWithCache.instance.loadImage(url: finalUrl) { [weak self] image in
            guard case let image else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}

extension URL {
    func upgradeUrl (url: URL) -> URL {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.scheme = "https"
        guard let finalUrl = urlComponents?.url else {
            return url
        }
        return finalUrl
    }
}
