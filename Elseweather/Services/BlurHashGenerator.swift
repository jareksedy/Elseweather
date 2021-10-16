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
        0000: ["dvEzGyRoIot6lCNHRjs:a9W9NHs:k6WAs:t4xUWCWYs,"], // reserved
        1000: ["d@Lq,[t7oeWVUHf6j]oeR*aejFa|nMj[WVayWYbIofj@"], // sunny & clear
        1003: ["dFGcih?wtl%2Y8I;00t700IpJV=|?b56WU?GR*M|oIE2"], // partly cloudy
        1006: ["dBHV--Dh00V?00xZ~URkVVxuSkSiM{D%WB^+RPe,ogW?"], // cloudy
        1009: ["d4BgVx0100~W00_4%M4nHX%NEM%19ar;_4D+^*00o#_4"], // overcast
        1030: ["dlGSfTWBWBof~pofayf6$*ofayayWCj[ayfkWVWCfkfQ"], // mist
    ]
    
    func generateFor(code: Int, day: Bool) -> BlurHashMatrix? {
        
        let dayIndex = day ? 0 : 1
        
        if blurHashForWeatherCode[code]?.isEmpty == false {
            if blurHashForWeatherCode[code]!.count > 1 {
                let bhString = blurHashForWeatherCode[code]![dayIndex]
                let matrix = BlurHash(string: bhString)?.components
                return matrix
            } else {
                let bhString = blurHashForWeatherCode[code]![0]
                let matrix = BlurHash(string: bhString)?.components
                return matrix
            }
        } else {
            let matrix = BlurHash(string: "00DGE0")?.components
            return matrix
        }
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

extension MutableCollection {
    mutating func updateEach(_ update: (inout Element) -> Void) {
        for i in indices {
            update(&self[i])
        }
    }
}
