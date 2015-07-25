//
//  Bag.swift
//  Studium
//
//  Created by Troy Stribling on 7/11/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public class Bag<T> : SequenceType {
   
    internal var vals : [T] = []

    public var isEmpty : Bool {
        return self.vals.count == 0
    }
    
    public var count : Int {
        return self.vals.count
    }
    

    public init() {}
    
    public init(vals:[T]) {
        self.vals = vals
    }
    
    public func add(val:T) {
        self.vals.append(val)
    }
    
    // SequenceType
    public func generate() -> BagGenerator<T> {
        return BagGenerator<T>(bag:self)
    }
    
}

public struct BagGenerator<T> : GeneratorType {
    
    private let bag : Bag<T>
    private var index = 0
    
    init(bag:Bag<T>) {
        self.bag = bag
    }
    
    public mutating func next() -> T? {
        if index < self.bag.count {
            return self.bag.vals[++index - 1]
        } else {
            return nil
        }
    }
    
}
