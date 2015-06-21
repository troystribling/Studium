//
//  ArrayExtensions.swift
//  Studium
//
//  Created by Troy Stribling on 6/20/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public struct ArrayTools {
    
    public static func fillUpTo(count:UInt32) -> [UInt32] {
        return (0..<count).map{$0}
    }
    
    public static func fillRandom(count:UInt32, upToValue:UInt32?=nil) -> [UInt32] {
        if let upToValue = upToValue {
            return (0..<count).map{_ in
                arc4random_uniform(upToValue+1)
            }
        } else {
            return (0..<count).map{_ in
                arc4random_uniform(count - 1)
            }
        }
    }
    
    public static func swap<T>(var vals:[T], index:Int, withIndex:Int) {
        let tmp = vals[index]
        vals[index] = vals[withIndex]
        vals[withIndex] = tmp
    }
    
    public static func shuffle<T>(vals:[T]) {
        for i in (0..<vals.count) {
            let shift = arc4random_uniform(UInt32(vals.count - 1 - i))
            self.swap(vals, index:i, withIndex:Int(shift))
        }
    }
    
}

