//
//  SafeArray.swift
//  Elseweather
//
//  Created by Jarek Šedý on 27.09.2021.
//

import Foundation

class ThreadSafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "Thread Safe Array", qos: .userInitiated, attributes: .concurrent)
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public func removeFirst() {
        queue.async(flags: .barrier) {
            let _ = self.array.removeFirst()
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
}
