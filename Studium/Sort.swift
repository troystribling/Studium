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
    
}