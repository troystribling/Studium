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

