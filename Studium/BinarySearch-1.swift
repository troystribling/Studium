//
//  BinarySearch-1.swift
//  Studium
//
//  Created by Troy Stribling on 8/29/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
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
    
    public static func max<T:Comparable>(vals:[T]) -> T {
        return self.max(vals, lo:0, hi:vals.count-1)
    }
    
    private static func max<T:Comparable>(vals:[T], lo:Int, hi:Int) -> T {
        print("hi-lo=\(hi-lo)")
        guard hi - lo > 1 else {
            if vals[lo] < vals[hi] {
                return vals[hi]
            } else {
                return vals[lo]
            }
        }
        let mid = lo + (hi - lo)/2
        print("lo=\(lo), hi=\(hi), mid=\(mid)")
        if vals[lo] > vals[mid] {
            print("left side is misordered: vals[lo]=\(vals[lo]), vals[mid]=\(vals[mid])")
            return self.max(vals, lo:lo, hi:mid)
        } else if vals[hi] < vals[mid] {
            print("right side is misordered: vals[mid]=\(vals[mid]), vals[hi]=\(vals[hi])")
            return self.max(vals, lo:mid, hi:hi)
        } else {
            print("array is ordered max found: vals[lo]=\(vals[lo]), vals[mid]=\(vals[mid]), vals[hi]=\(vals[hi])")
            return vals[hi]
        }
    }
}