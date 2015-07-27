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
    public func generate() -> AnyGenerator<T> {
        var index = 0
        return anyGenerator{
            if index < self.count {
                return self.vals[index++]
            } else {
                return nil
            }
        }
    }
    
}
