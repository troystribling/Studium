//
//  Search.swift
//  Studium
//
//  Created by Troy Stribling on 7/12/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation


// Union Find constructs a connected network of nodes
public protocol UnionFind {
    
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

public extension UnionFind {
    
    // two nodes in the network are network are considered connected if their network idetifiers are equal
    func connected(p:Int, q:Int) -> Bool {
        return self.find(p) == self.find(q)
    }
    
}

// Quick Find implementation optimizes find but slow union
public class UnionFindQuickFind : UnionFind {

    // array indexed by node value. For quick find implemenation network identifier is stored at node id
    private var ids : [Int] = []
    
    // number of networks
    private var n : Int = 0
    
    public var count : Int {
        return self.n
    }
    
    public var network : [Int] {
        return self.ids
    }
    
    public init() {
    }
    
    public init(n:Int) {
        self.n = n
        self.ids = ArrayTools.fillUpTo(n)
    }
    
    // network identifier is stored at node identier
    public func find(p:Int) -> Int {
        return self.ids[p]
    }
    
    // cooenct 2 nodes in network
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
        --self.n
    }
}

public class UnionFindQuickUnion : UnionFind {
    
    private var ids : [Int] = []
    private var n : Int = 0
    
    public var count : Int {
        return self.n
    }
    
    public var nodes : [Int] {
        return self.ids
    }
    
    public init(n:Int) {
        self.n = n
        self.ids = ArrayTools.fillUpTo(n)
    }
    
    public func find(p:Int) -> Int {
    }
    
    public func union(p:Int, q:Int) {
    }
}