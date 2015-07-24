//
//  Search.swift
//  Studium
//
//  Created by Troy Stribling on 7/12/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation


// Union Find constructs a connected network of nodes and supports queries to determie connectivity
public protocol UF {
    
    // number of connected networks
    var count : Int     {get}
    
    // network node ids are array index but intepretation of value depnds on implementation but it always identifies the 
    // network containing the node. All nodes with same network identifier are in the same network
    var network : [Int]   {get}
    
    // true if nodes with ids p and q are in the same network
    func connected(p:Int, q:Int) -> Bool
    
    // return the network identifier for node with id q
    func find(p:Int) -> Int
    
    // add network connection between nodes with the ids p in q
    func union(p:Int, q:Int)
    
}

public extension UF {
    
    // two nodes in the network are network are considered connected if their network idetifiers are equal
    func connected(p:Int, q:Int) -> Bool {
        return self.find(p) == self.find(q)
    }
    
}

// Quick Find implementation optimizes find but union is quadratic
public class UFQuickFind : UF {

    // ids array indexed by node id. For quick find implemenation network identifier is stored at node id
    private var ids : [Int]
    
    // number of networks
    private var n : Int
    
    public var count : Int {
        return self.n
    }
    
    public var network : [Int] {
        return self.ids
    }
    
    // ids array is inialized with index == ids[index] and the numbre of networks to the total number of nodes.
    public init(count:Int) {
        self.n = count
        self.ids = ArrayTools.fillUpTo(self.n)
    }
    
    // network identifier is stored at node identier
    public func find(p:Int) -> Int {
        return self.ids[p]
    }
    
    // connect 2 nodes in network
    public func union(p:Int, q:Int) {
        let pid = self.find(p), qid = find(q)
        // return if nodes are in same netwok
        guard pid != qid else {
            return
        }
        // loop through all nodes and add p network to q network
        for i in (0..<ids.count) {
            if self.ids[i] == pid {
                self.ids[i] = qid
            }
        }

        // decrement the number of networks by one
        --self.n
    }
}


// Quick Union an attempt to spped up union at expense of find
public class UFQuickUnion : UF {
    
    // ids array index is node id. Array contents is a forest of trees model of the network. Data at node id index contains
    // node id of parent. Root node of tree is used to identify network.
    private var ids : [Int]
    private var n : Int
    
    public var count : Int {
        return self.n
    }
    
    public var network : [Int] {
        return self.ids
    }
    
    
    // ids array is inialized with index == ids[index].
    // The number of networks is initialized to the toal number of nodes
    public init(count:Int) {
        self.n = count
        self.ids = ArrayTools.fillUpTo(self.n)
    }
    
    // find traverses network tree up from node p to root. Tree traversal is implemented by composing ids array until root is reached
    // root in ids array is identified by index == ids[index] or root id == ids[ids[ids[...ids[p]]]]
    public func find(var p:Int) -> Int {
        while p != self.ids[p] {
            p = self.ids[p]
        }
        return p
    }
    
    // connect nodes pa nd q in the network. p and q are in same network tree if they have the same root. if they have the same root do nothing.
    // If they do not have the same root make root of q tree a child of root of p tree.
    public func union(p:Int, q:Int) {
        // get root nodes for p and q
        let i = self.find(p)
        let j = self.find(q)
        // exit if root nods are equal
        guard i != j else {
            return
        }
        // make tree with root j a child of tree with root i
        self.ids[i] = j
        
        // decrement the number of networks by one
        --self.n
    }
}

// Wieighted Quick Union bset perfromance for both find and union
public class UFWeightedQuickUnion : UF {
    // array index is node id. Array conetnts is a forrest of trees model of network. Data at node id index contains
    // mode id of parent. Root node of tre is network identifier
    private var ids :[Int]
    // arry index is node id. Array contents is number of children for node
    private var size : [Int]
    private var n : Int
    
    public var count : Int {
        return self.n
    }
    
    public var network : [Int] {
        return self.ids
    }
    
    // ids array is inialized with index = ids[index]
    public init(count:Int) {
        self.n = count
        self.ids = ArrayTools.fillUpTo(self.n)
        self.size = [Int](count:self.n, repeatedValue:1)
    }
    
    // find traverses network tree up from node p to root. Tree traversal is implemented by composing ids array until root is reached.
    // root is identified by index = ids[index] or root id = ids[ids[ids[...ids[p]]]]
    public func find(var p:Int) -> Int {
        while(p != self.ids[p]) {
            p = self.ids[p]
        }
        return p
    }
    
    // connect nodes p and q in the network. If p and q have the same root they are in the same network so do nothing. If p and q are 
    // not in the same network add the smallest network to the largest. This will at most increase the depth of the network by 1 when the
    // two combinded networks are the same size,
    public func union(p:Int, q:Int) {
        // get root nodes for p and q
        let i = self.find(p)
        let j = self.find(q)

        // if root nodes are equal pa nd q are in same netwok so exit.
        guard i != j else {
            return
        }
        if self.size[i] < self.size[j] {
            // if network with root i is smaller make i a child of of j and increase the size of i by the size of j
            self.ids[i] = j
            self.size[j] += self.size[i]
        } else {
            // if network j is smaller or equal in size to network i make i a child of j and increase the size
            // of network i by the size of network j
            self.ids[j] = i
            self.size[i] += self.size[j]
        }
        // decrement the number of networks by 1
        --self.n
    }
}

// Binary search
// Find the index in values of key. values is assumed to be sorted
public struct BinarySearch {
    
    // return the index of key in values
    public static func rank<T:Comparable>(key:T, values:[T]) -> Int? {
        // initiate recursive calls that
        return self.rank(key, values:values, lo:0, hi:values.count-1)
    }
    
    // return the index of key in values where the range of indexes lies between lo and hi
    public static func rank<T:Comparable>(key:T, values:[T], lo:Int, hi:Int) -> Int? {
        // key not found
        guard lo <= hi else {
            return nil
        }
        // test mid as key rank
        let mid = lo + (hi - lo)/2
        if key < values[mid] {
            // rank is less than mid look to right for rank between lo and mid-1
            return self.rank(key, values:values, lo:lo, hi:mid - 1)
        } else if key > values[mid] {
            // rank is larger than mid look to left for rank between mid+1 and hi
            return self.rank(key, values:values, lo:mid+1, hi:hi)
        } else {
            // rank found
            return mid
        }
    }
}

// Symbol Table implemented with binary search
public struct STBinarySearchGenerator<Key:Comparable,Value> : GeneratorType {

    let st : STBinarySearch<Key, Value>
    var i = 0
    
    init(st:STBinarySearch<Key, Value>) {
        self.st = st
    }
    
    public mutating func next() -> Key? {
        if i < st.count {
            let key = st.keys[i]
            ++i
            return key
        } else {
            return nil
        }
    }
}

public class STBinarySearch<Key:Comparable, Value> : CollectionType {
    
    // store keys in array and values in array indexed by key rank
    internal var keys : [Key]
    internal var values : [Value]
    internal var n : Int = 0
    
    public init() {
        self.values = [Value]()
        self.keys = [Key]()
    }
    
    public init (capacity:Int, initialKey:Key, initialValue:Value) {
        self.values = [Value](count:capacity, repeatedValue:initialValue)
        self.keys = [Key](count:capacity, repeatedValue:initialKey)
    }
    
    // return minimum key
    var min : Key? {
        return self.first
    }
    
    // return maximum key
    var max : Key? {
        return self.last
    }
    
    // get value for key
    public func get(key:Key) -> Value? {
        // table has no keys
        guard !self.isEmpty else {
            return nil
        }
        let i = self.rank(key)
        print("key=\(key), rank=\(i)")
        if i < self.n && self.keys[i] == key {
            print("key found")
            // value found
            return self.values[i]
        } else {
            print("key not found")
            // value not found
            return nil
        }
    }
    
    // add value to symbol table with key
    public func put(key:Key, value:Value) {
        // rank is number of keys in self.keys less than key
        let i = self.rank(key)
        print("key=\(key), value=\(value), rank=\(i)")
        // key is in table. update value and do not increment count
        if i < self.n && self.keys[i] == key {
            print("updating value")
            self.values[i] = value
            return
        }
        // key is not in self.keys location in keys is i
        if i < self.keys.count {
            // need to make room for key. move all keys left by one position.
            for var j = self.n; j > i; --j {
                self.keys[j] = self.keys[j-1]
                self.values[j] = self.values[j-1]
            }
            self.keys[i] = key
            self.values[i] = value
        } else {
            print("growing array add to end")
            // array capacity reached add key tp end of keys
            self.keys.append(key)
            self.values.append(value)
        }
        ++self.n
        print(keys)
        print(values)
    }
    
    public func delete(key:Key) {
    }
    
    // return the number of keys in self.keys smaller than key. If key is in self.keys this will be the index
    // of key. If key is not in self.keys this will be the index key would have if it were in keys.
    public func rank(key:Key) -> Int {
        var lo = 0, hi = self.n - 1
        while lo <= hi {
            let mid = lo + (hi - lo)/2
            let testKey = self.keys[mid]
            if testKey > key {
                // key is smaller than test key look to right for rank between lo and mid-1
                hi = mid - 1
            } else if testKey < key {
                // key is larger than testKey look to left for rank between mid+1 and hi
                lo = mid + 1
            } else {
                // key found return rank
                return mid
            }
        }
        // no key found rank will be last value of lo. This follows since at previous step key was between
        // lo < key < mid where mid = lo + 1 since serach would have been exhaustive
        return lo
    }
    
    // CollectionType
    public func generate() -> STBinarySearchGenerator<Key, Value> {
        return STBinarySearchGenerator(st: self)
    }
    
    public var count : Int {
        return self.n
    }
    
    public var isEmpty : Bool {
        return self.count == 0
    }
    
    public var first : Key? {
        if self.count > 0 {
            return self.keys.first
        } else {
            return nil
        }
    }
    
    public var last : Key? {
        if self.count > 0 {
            return self.keys[self.count]
        } else {
            return nil
        }
    }
}