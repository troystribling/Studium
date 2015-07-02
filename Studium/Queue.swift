//
//  Queue.swift
//  Studium
//
//  Created by Troy Stribling on 7/1/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

// binary heap implementaion of priority queue
public class MaxPriorityQ<T:Comparable> {
    
    private var vals    = [T]()
    private var n : Int = 0
    
    public init() {
    }
    
    public var isEmpty : Bool {
        return self.n == 0
    }
    
    public var size : Int {
        return self.n
    }
    
    public func insert(val:T) {
        self.vals.append(val)
        ++self.n
        self.swim(self.n)
    }
    
    public func delMax() -> T? {
        if let maxVal = self.vals.first {
            --self.n
            ArrayTools.swap(&self.vals, index:0, withIndex:self.n)
            self.vals.removeLast()
            self.sink(0)
            return maxVal
        } else {
            return nil
        }
    }
    
    // raise node in tree untill heap ordered
    public func swim(var k:Int) {
        // k=child node, j=parent node
        while k > 1 {
            let j = k/2
            if self.vals[self.toIndex(j)] < self.vals[self.toIndex(k)] {
                // child is greater swim higher
                ArrayTools.swap(&self.vals, index:self.toIndex(j), withIndex:self.toIndex(k))
                k = j
            } else {
                // child <= parent heap order obtained
                break
            }
        }
    }
    
    // lower node in tress untill heap ordered
    public func sink(var k:Int) {
        // k=parent node, j = child node
        while 2*k < self.n {
            var j = 2*k
            // compare to largest child if two are present. if j > self.n there is only one child
            if (j < self.n) && self.vals[self.toIndex(j)] < vals[self.toIndex(j+1)] {
                ++j
            }
            if self.vals[k] < self.vals[j] {
                // parent is less than child sink lower
                ArrayTools.swap(&self.vals, index:self.toIndex(k), withIndex:self.toIndex(j))
                k=j
            } else {
                // parent is >= child heap order obtained
                break
            }
        }
    }
    
    // map node number to array index
    public func toIndex(k:Int) -> Int {
        return k - 1
    }
}
    