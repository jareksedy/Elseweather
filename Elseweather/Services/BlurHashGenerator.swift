//
//  BlurHashGenerator.swift
//  Elseweather
//
//  Created by Jarek Šedý on 30.09.2021.
//

import Foundation

class BlurHashGenerator {
    func generate(for code: Int, width: Int, height: Int) {
        
    }
    
    private func rndBHC(_ top: Float?) -> BlurHashComponent {
        if let top = top {
            return (Float.random(in: 0...top), Float.random(in: 0...top), Float.random(in: 0...top))
        } else {
            return (Float.random(in: 0...1), Float.random(in: 0...1), Float.random(in: 0...1))
        }
    }
}
