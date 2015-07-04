//
//  Queue.swift
//  Studium
//
//  Created by Troy Stribling on 7/1/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

// binary heap implementaion of priority queue
// binary heap node numbering
// k = parent node number
// 2*k = left child node number
// 2*k + 1 = right child node number
// j = child node number
// j/2 = parent node number
// val[k] >= val2*k] && val[k] >= val[2k+1]
// vals[0] is largest value
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
            // convert to node ids to array index
            let ji = j-1, ki = k-1
            if self.vals[ji] < self.vals[ki] {
                // child is greater swim higher
                ArrayTools.swap(&self.vals, index:ji, withIndex:ki)
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
        while 2*k <= self.n {
            var j = 2*k
            // convert to node ids to array index
            var ji = j-1, ki = k-1
            // compare to largest child if two are present. if j > self.n there is only one child
            if (j < self.n) && self.vals[ji] < self.vals[ji+1] {
                ++j; ++ji
            }
            if self.vals[ki] < self.vals[ji] {
                // parent is less than child sink lower
                ArrayTools.swap(&self.vals, index:ki, withIndex:ji)
                k=j
            } else {
                // parent is >= child heap order obtained
                break
            }
        }
    }
    
}

public class Queue<T> {
    
    private var vals = [T]()
    
    public var isEmpty : Bool {
        return self.vals.count == 0
    }
    
    public var size : Int {
        return self.vals.count
    }

    public init() {
    }
    
    public func enqueue(val:T) {
        self.vals.append(val)
    }
    
    public func dequeue() -> T? {
        return self.isEmpty ? nil : self.vals.removeAtIndex(0)
    }
    
}
    