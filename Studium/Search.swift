//
//  Search.swift
//  Studium
//
//  Created by Troy Stribling on 7/12/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public protocol UnionFind {
    
    var count : Int     {get}
    var nodes : [Int]   {get}
    
    func connected(p:Int, q:Int) -> Bool
    func find(p:Int) -> Int
    func union(p:Int, q:Int)
    
}

public extension UnionFind {
    
    func connected(p:Int, q:Int) -> Bool {
        return self.find(p) == self.find(q)
    }
    
}

public class UnionQuickFind : UnionFind {
    
    private var ids : [Int] = []
    private var n : Int = 0
    
    public var count : Int {
        return self.n
    }
    
    public var nodes : [Int] {
        return self.ids
    }
    
    public init() {
    }
    
    public init(n:Int) {
        self.n = n
        self.ids = ArrayTools.fillUpTo(n)
    }
    
    public func find(p:Int) -> Int {
        return self.ids[p]
    }
    
    public func union(p:Int, q:Int) {
        let pid = self.find(p), qid = find(q)
        guard pid != qid else {
            return
        }
        for i in (0..<ids.count) {
            if self.ids[i] == pid {
                self.ids[i] = qid
            }
        }
        --self.n
    }
}