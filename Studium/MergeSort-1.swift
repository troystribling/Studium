//
//  MergeSort-1.swift
//  Studium
//
//  Created by Troy Stribling on 8/29/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct MergeSort1 {
    
    private static func merge<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, mid:Int, hi:Int) {
        // i=lower index j=upper index
        var i = lo, j = mid+1
        for k in (lo...hi) {
            tmp[k] = vals[k]
        }
        for k in (lo...hi) {
            // lower array exhausted
            if i > mid {
                vals[k] = tmp[j++]
            // upper array exhausted
            } else if j > hi {
                vals[k] = tmp[i++]
            // upper value larger
            } else if tmp[j] > tmp[i] {
               vals[k] = tmp[i++]
            // lower value larger
            } else {
                vals[k] = tmp[j++]
            }
        }
    }
    
    private static func sort<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, hi:Int) {
        guard hi > lo else {
            return
        }
        let mid = lo + (hi - lo)/2
        self.sort(&vals, tmp:&tmp, lo:lo, hi:mid)
        self.sort(&vals, tmp:&tmp, lo:mid+1, hi:hi)
        self.merge(&vals, tmp:&tmp, lo:lo, mid:mid, hi:hi)
    }
    
    public static func sort<T:Comparable>(inout vals:[T]) {
        var tmp = vals
        self.sort(&vals, tmp:&tmp, lo:0, hi:vals.count-1)
    }
    
}


public struct MergeSort2 {
    
    private static func merge<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, mid:Int, hi:Int) {
        var i = lo; var j = mid+1
        // load tmp
        for k in (lo...hi) {
            tmp[k] = vals[k]
        }
        for k in (lo...hi) {
            // left side exhausted
            if i > mid {
              vals[k] = tmp[j++]
            // right side exhausted
            } else if j > hi {
                vals[k] = tmp[i++]
            // right side larger
            } else if tmp[j] > tmp[i] {
               vals[k] = tmp[i++]
            // left side larger
            } else {
                vals[k] = tmp[j++]
            }
        }
    }
    
    private static func sort<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, hi:Int) {
        guard lo < hi else {
            return
        }
        let mid = lo + (hi-lo)/2
        self.sort(&vals, tmp:&tmp, lo:lo, hi:mid)
        self.sort(&vals, tmp:&tmp, lo:mid+1, hi:hi)
        self.merge(&vals, tmp:&tmp, lo:lo, mid:mid, hi:hi)
    }
    
    public static func sort<T:Comparable>(inout vals:[T]) {
        var tmp = vals
        self.sort(&vals, tmp:&tmp, lo:0, hi:vals.count-1)
    }
}