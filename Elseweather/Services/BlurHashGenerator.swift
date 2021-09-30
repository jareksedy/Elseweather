//
//  BlurHashGenerator.swift
//  Elseweather
//
//  Created by Jarek Šedý on 30.09.2021.
//

import Foundation
import SwiftUI

class BlurHashGenerator {
    
    private let blurHashForWeatherCode = [
        1000: ["SnKKQOoK.ToK0nayD*az", "SSExX{}=?bt6169^9wNH"],
    ]
    
    func generateFor(code: Int, day: Bool) -> BlurHashMatrix? {
        //        guard let blurHash = blurHashForWeatherCode[code],
        //              let blurHashMatrix = BlurHash(string: blurHash[day ? 0 : 1])?.components else { return nil }
        //        let bhMatrix = BlurHash(string: "SSExX{}=?bt6169^9wHN")!.components
        //        var result: BlurHashMatrix = []
        //        bhMatrix.forEach { vector in
        //            result.append(vector.shuffled())
        //        }
        
        let matrix = generateRandomMatrix(width: bhMatrixWidth, height: bhMatrixHeight, top: 0.35, bottom: 0.15)
        print(BlurHash(components: matrix).string)
        return matrix
    }
    
    func generateRandomMatrix(width: Int, height: Int, top: Float? = nil, bottom: Float? = 0) -> BlurHashMatrix {
        if let top = top, let bottom = bottom {
            return (0..<height).map { _ in (0..<width).map{ _ in rndBHC(top, bottom) }}
        } else {
            return (0..<height).map { _ in (0..<width).map{ _ in rndBHC() }}
        }
    }
    
    func generateImage(components: BlurHashMatrix, reducedBy: CGFloat, punch: Float, _ completion: @escaping (UIImage) -> ()) {
        let size = CGSize(width: Int(screenWidth / reducedBy), height: Int(screenHeight / reducedBy))
        let blurHashString = BlurHash(components: components).string
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let image = UIImage(blurHash: blurHashString, size: size, punch: punch) else { return }
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    private func rndBHC(_ top: Float? = nil, _ bottom: Float? = 0) -> BlurHashComponent {
        if let top = top, let bottom = bottom {
            return (Float.random(in: bottom...top), Float.random(in: bottom...top), Float.random(in: bottom...top))
        } else {
            return (Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1))
        }
    }
}
