//
//  BinarySerach-1.swift
//  Studium
//
//  Created by Troy Stribling on 8/29/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct BinarySearch1 {
    
    public static func rank<T:Comparable>(key:T, values:[T]) -> Int? {
        return self.rank(key, values:values, lo:0, hi:values.count-1)
    }
    
    private static func rank<T:Comparable>(key:T, values:[T], lo:Int, hi:Int) -> Int? {
        guard lo <= hi else {
            return nil
        }
        let mid = lo + (hi - lo)/2
        if key < values[mid] {
            return self.rank(key, values:values, lo:lo, hi:mid-1)
        } else if key > values[mid] {
            return self.rank(key, values:values, lo:mid+1, hi:hi)
        } else {
            return mid
        }        
    }
    
}

public struct MaxRotatedArray {
    
    public static func max<T:Comparable>(vals:[T]) -> T? {
        return self.max(vals, lo:0, hi:vals.count)
    }
    
    private static func max<T:Comparable>(vals:[T], lo:Int, hi:Int) -> T? {
        guard lo <= hi else {
            return nil
        }
        let mid = lo + (hi - lo)/2
        if vals[lo] > vals[mid] {
            return self.max(vals, lo:lo, hi:mid-1)
        } else if vals[hi] < vals[mid] {
            return self.max(vals, lo:mid+1, hi:hi)
        }
    }
}