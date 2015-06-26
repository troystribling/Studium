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

    public static func fillReversedUpTo(count:UInt32) -> [UInt32] {
        return (0..<count).map{count - 1 - $0}
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
    
    public static func swap<T>(inout vals:[T], index:Int, withIndex:Int) {
        let tmp = vals[index]
        vals[index] = vals[withIndex]
        vals[withIndex] = tmp
    }
    
    public static func shuffle<T>(inout vals:[T]) {
        for i in (0..<vals.count-1) {
            let shift = Int(arc4random_uniform(UInt32(vals.count - 1 - i))) + i + 1
            self.swap(&vals, index:i, withIndex:shift)
        }
    }
    
    public static func sorted<T:Comparable>(vals:[T]) -> Bool {
        var status = true
        for i in (1..<vals.count) {
            if vals[i-1] > vals[i] {
                status = false
                break
            }
        }
        return status
    }
}

