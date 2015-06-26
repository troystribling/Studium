//
//  Sort.swift
//  Studium
//
//  Created by Troy Stribling on 6/21/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct Sort {
    
    // implementation of selection sort
    public struct Selection {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            var minVal : Int
            for i in (0..<vals.count) {
                minVal = i
                for j in (i..<vals.count) {
                    if vals[minVal] > vals[j] {
                        minVal = j
                    }
                }
                ArrayTools.swap(&vals, index:i, withIndex:minVal)
            }
        }
        
    }
    
    // implementaion of insertion sort
    public struct Insertion {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            for i in (1..<vals.count) {
                for j in reverse(1...i) {
                    if vals[j] < vals[j-1] {
                        ArrayTools.swap(&vals, index:j, withIndex:j-1)
                    } else {
                        break
                    }
                }
            }
        }
        
    }
    
    // implementation of shell sort
    public struct Shell {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            let n = vals.count
            var h = 1;
            while h < n/3 {
                h = 3*h+1
            }
            while h > 0 {
                self.hsort(&vals, h:h)
                h = h/3
            }
        }

        public static func hsort<T:Comparable>(inout vals:[T], h:Int) {
            for i in (h..<vals.count) {
                for var j = i; j >= h; j -= h {
                    if vals[j] < vals[j-h] {
                        ArrayTools.swap(&vals, index:j, withIndex:j-h)
                    } else {
                        break
                    }
                }
            }
        }
    }
    
    // implementaion of merge sort
    public struct MergeTopDown {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            var tmp = vals
            self.sort(&vals, tmp:&tmp, lo:0, hi:vals.count-1)
        }
        
        public static func sort<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, hi:Int) {
            if hi <= lo {
                return
            }
            let mid = lo + (hi - lo)/2
            self.sort(&vals, tmp: &tmp, lo:lo, hi:mid)
            self.sort(&vals, tmp: &tmp, lo:mid+1, hi:hi)
            self.merge(&vals, tmp:&tmp, lo:lo, mid:mid, hi:hi)
        }
        
        // merge 2 sorted portions of array first is lo...mid second is mid+1...hi
        public static func merge<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, mid:Int, hi:Int) {
            var i = lo
            var j = mid + 1
            for k in (lo...hi) {
                tmp[k] = vals[k]
            }
            for k in (lo...hi) {
                // lower array exhausted
                if i > mid {
                    vals[k] = tmp[j]
                    ++j
                // upper array exhausted
                } else if j > hi {
                    vals[k] = tmp[i]
                    ++i
                // upper array larger
                } else if tmp[j] > tmp[i] {
                    vals[k] = tmp[i]
                    ++i
                // lower array larger
                } else {
                    vals[k] = tmp[j]
                    ++j
                }
            }
        }
    }
    
}