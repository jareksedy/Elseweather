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
        0: ["FF0000", "00FF00", "0000FF", "FF00FF"],
        1000: ["8C1822", "F24B78", "3B67BF", "141640"]
    ]
    
    func generateFor(code: Int, day: Bool) -> BlurHashMatrix? {
     //   var colors: [String] = []
        
        //        guard let blurHash = blurHashForWeatherCode[code],
        //              let blurHashMatrix = BlurHash(string: blurHash[day ? 0 : 1])?.components else { return nil }
        //        let bhMatrix = BlurHash(string: "SSExX{}=?bt6169^9wHN")!.components
        //        var result: BlurHashMatrix = []
        //        bhMatrix.forEach { vector in
        //            result.append(vector.shuffled())
        //        }
        
        //let matrix = generateRandomMatrix(width: bhMatrixWidth, height: bhMatrixHeight, top: 0.35, bottom: 0.20)
        
//        if blurHashForWeatherCode[code] != nil {
//            colors = blurHashForWeatherCode[code]!
//        } else {
//            colors = blurHashForWeatherCode[0]!
//        }
        
      //  let matrix = BlurHash(blendingTopLeft: hexToUIColor(colors[0]),
//                              topRight: hexToUIColor(colors[1]),
//                              bottomLeft: hexToUIColor(colors[2]),
//                              bottomRight: hexToUIColor(colors[3])).components
        
            let colors = ["004488", "444400"]
               let matrix = generateMatrix(width: 2, height: 3, from: colors)
        //
        //        print(BlurHash(components: matrix).string)
        
        //        let bh = BlurHash(string: "S~M#.g~l~m~l~p~p}K~o")
        //        var matrix: BlurHashMatrix = []
        //        bh!.components.forEach { vector in
        //            matrix.append(vector.shuffled())
        //        }
        
        return matrix
    }
    
    func generateMatrix(width: Int, height: Int, from: [String]) -> BlurHashMatrix {
        return (0..<height).map { _ in (0..<width).map{ _ in hexToBHC(from.randomElement()!) }}
    }
    
    func generateRandomMatrix(width: Int, height: Int, top: Float? = nil, bottom: Float? = 0) -> BlurHashMatrix {
        if let top = top, let bottom = bottom {
            return (0..<height).map { _ in (0..<width).map{ _ in rndBHC(top, bottom) }}
        } else {
            return (0..<height).map { _ in (0..<width).map{ _ in rndBHC() }}
        }
    }
    
    func generateImage(components: BlurHashMatrix, reducedBy: CGFloat, punch: Float, _ completion: @escaping (Image) -> ()) {
        let size = CGSize(width: Int(screenWidth / reducedBy), height: Int(screenHeight / reducedBy))
        let blurHashString = BlurHash(components: components).string
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let image = UIImage(blurHash: blurHashString, size: size, punch: punch) else { return }
            
            DispatchQueue.main.async {
                completion(Image(uiImage: image))
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
    
    private func hexToBHC(_ hexString: String) -> BlurHashComponent {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = Float(r) / 255.0
        let green = Float(g) / 255.0
        let blue  = Float(b) / 255.0
        
        return (red, green, blue)
    }
    
    private func hexToUIColor(_ hexString: String) -> UIColor {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
