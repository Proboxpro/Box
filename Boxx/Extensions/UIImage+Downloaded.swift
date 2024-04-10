//
//  UIImage+Downloaded.swift
//  Boxx
//
//  Created by Максим Алексеев  on 17.03.2024.
//

import Foundation
import UIKit

extension UIImage {
    static func downloaded(from url: URL) async -> UIImage {
        return await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data1 = data, error == nil,
                    let image = UIImage(data: data1)
                else { return }
                
                continuation.resume(returning: image)
            }.resume()
        }
    }
    
//    static func downloaded(from link: String?, completion: @escaping (UIImage) -> ()) {
//        guard
//            let link = link,
//            let url = URL(string: link)
//        else { return }
//        downloaded(from: url, completion: completion)
//    }
}
