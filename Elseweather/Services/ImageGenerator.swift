//
//  BlurHashGenerator.swift
//  Elseweather
//
//  Created by Jarek Šedý on 30.09.2021.
//

import Foundation
import SwiftUI

class ImageGenerator {
    
    func generate(string: String, reducedBy: CGFloat, punch: Float, _ completion: @escaping (Image) -> ()) {
        let size = CGSize(width: Int(screenWidth / reducedBy), height: Int(screenHeight / reducedBy))
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let image = UIImage(blurHash: string, size: size, punch: punch) else { return }
            
            DispatchQueue.main.async {
                completion(Image(uiImage: image))
            }
        }
    }
}
