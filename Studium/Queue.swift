//
//  Queue.swift
//  Studium
//
//  Created by Troy Stribling on 7/1/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

// Priority Queue
// binary heap implementaion of priority queue
// binary heap node numbering
// k = parent node number
// 2*k = left child node number
// 2*k + 1 = right child node number
// j = child node number
// j/2 = parent node number
// compare(val[k], rks:val2*k]) && compare(val[k], val[2k+1])
// vals[0] compares successfully with all children
public protocol PriorityQ : class {
    typealias T : Comparable
    var vals : [T] {get set}
    var n  : Int {get set}
    var isEmpty : Bool {get}
    var size : Int {get}
    func compare(lhs:T, rhs:T) -> Bool
    func insert(val:T)
    func delRoot() -> T?
    func swim(var k:Int)
    func sink(var k:Int)
}

public extension PriorityQ {
    
    var isEmpty : Bool {
        return self.n == 0
    }
    
    var size : Int {
        return self.n
    }

    func insert(val:T) {
        self.vals.append(val)
        ++self.n
        self.swim(self.n)
    }

    func delRoot() -> T? {
        if let maxVal = self.vals.first {
            --self.n
            ArrayTools.swap(&self.vals, index:0, withIndex:self.n)
            self.vals.removeLast()
            self.sink(1)
            return maxVal
        } else {
            return nil
        }
    }

    // raise node in tree untill heap ordered
    func swim(var k:Int) {
        // k=child node, j=parent node
        while k > 1 {
            let j = k/2
            // convert to node ids to array index
            let ji = j-1, ki = k-1
            if self.compare(self.vals[ji], rhs:self.vals[ki]) {
                // child is not heap ordered swim higher
                ArrayTools.swap(&self.vals, index:ji, withIndex:ki)
                k = j
            } else {
                // child is heap order obtained
                break
            }
        }
    }
    
    // lower node in tress untill heap ordered
    func sink(var k:Int) {
        // k=parent node, j = child node
        while 2*k <= self.n {
            var j = 2*k
            // convert to node ids to array index
            var ji = j-1, ki = k-1
            // compare light and right children if two are present. if j > self.n there is only one child
            if (j < self.n) && self.compare(self.vals[ji], rhs:self.vals[ji+1]) {
                ++j; ++ji
            }
            if self.compare(self.vals[ki], rhs:self.vals[ji]) {
                // parent is not heap ordered sink lower
                ArrayTools.swap(&self.vals, index:ki, withIndex:ji)
                k=j
            } else {
                // parent is heap order obtained
                break
            }
        }
    }

}

// Minimum Priority Queue
// binary heap implementaion of priority queue
// binary heap node numbering
// k = parent node number
// 2*k = left child node number
// 2*k + 1 = right child node number
// j = child node number
// j/2 = parent node number
// val[k] <= val2*k] && val[k] <= val[2k+1]
// [2,2,5,3,4,8,9]
// vals[0] is smalles value
public final class MinPriorityQ<T:Comparable> : PriorityQ {
    
    public var vals : [T] = []
    public var n = 0

    public init() {}

    public init(vals:[T]) {
        self.vals = vals
        self.n = self.vals.count
        for k in (1...self.n/2).reverse() {
            self.sink(k)
        }
    }

    public func compare(lhs:T, rhs:T) -> Bool {
        return lhs > rhs
    }
    
    public func delMin() -> T? {
        return self.delRoot()
    }

}

// Maximum Priority Queue
// binary heap implementaion of priority queue
// binary heap node numbering
// k = parent node number
// 2*k = left child node number
// 2*k + 1 = right child node number
// j = child node number
// j/2 = parent node number
// val[k] >= val2*k] && val[k] >= val[2k+1]
// [10,9,6,2,1,3,2]
// vals[0] is largest value
public class MaxPriorityQ<T:Comparable> : PriorityQ {
    
    public var vals : [T] = []
    public var n = 0

    public init() {}
    
    public init(vals:[T]) {
        self.vals = vals
        self.n = self.vals.count
        for k in (1...self.n/2).reverse() {
            self.sink(k)
        }
    }
    
    public func compare(lhs:T, rhs:T) -> Bool {
        return lhs < rhs
    }
    
    public func delMax() -> T? {
        return self.delRoot()
    }

}

// FIFO Queue
public struct QueueGenerator<T> : GeneratorType {
    let queue : Queue<T>
    public mutating func next() -> T? {
        return self.queue.dequeue()
    }
}

public class Queue<T> : SequenceType {
    
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
    
    // SequenceType
    public func generate() -> QueueGenerator<T> {
        return QueueGenerator(queue:self)
    }

}
    