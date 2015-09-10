//
//  Array-1.swift
//  Studium
//
//  Created by Troy Stribling on 9/9/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct ArrayExercise {
    
    public static func rotate<T>(inout vals:[T], pivot:Int) {
        // reverse entire array
        self.reverse(&vals, lo:0, hi:vals.count-1)
        // reorder vals below pivot
        self.reverse(&vals, lo:0, hi:pivot-1)
        // reorder vals above pivot
        self.reverse(&vals, lo:pivot, hi:vals.count-1)
    }
    
    public static func reverse<T>(inout vals:[T], lo:Int, hi:Int) {
        let mid = (hi - lo)/2
        for var i = 0; i <= mid; i++ {
            self.swap(&vals, i:lo+i, j:hi-i)
        }
        
    }
    
    public static func swap<T>(inout vals:[T], i:Int, j:Int) {
        (vals[j], vals[i]) = (vals[i], vals[j])
    }
}