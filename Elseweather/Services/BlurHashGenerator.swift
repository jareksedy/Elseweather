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
        1000: "dMFiDkF_5+^72|pLw^ROL3-rmjKj8_Eht1jFw|ROozw]", // sunny & clear
        1003: "dFGcih?wtl%2Y8I;00t700IpJV=|?b56WU?GR*M|oIE2", // partly cloudy
        1006: "dBHV--Dh00V?00xZ~URkVVxuSkSiM{D%WB^+RPe,ogW?", // cloudy
        1009: "d272KwVY?^MxM{j]%gRP00W;8^WB00IAo}%gs,%gx]M_", // overcast
        1030: "d9FY+7D,00IT-;D%aKRO00M_~Wxv?bM_D%?H~qt89ZM_", // mist
    ]
    
    func generateFor(code: Int, day: Bool) -> BlurHashMatrix? {
        
       // let dayIndex = day ? 0 : 1
        
        guard let bhString = blurHashForWeatherCode[code] else {
            return BlurHash(string: "00DGE0")?.components
        }
        
        let matrix = BlurHash(string: bhString)?.components
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

extension MutableCollection {
  mutating func updateEach(_ update: (inout Element) -> Void) {
    for i in indices {
      update(&self[i])
    }
  }
}
