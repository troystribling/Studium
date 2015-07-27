//
//  Stack.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation


public class Stack<T> : SequenceType {
    
    internal var vals = [T]()

    public var isEmpty : Bool {
        return self.vals.count == 0
    }
    
    public var count : Int {
        return self.vals.count
    }
    
    public init() {
    }
    
    public func push(val:T) {
        self.vals.append(val)
    }
    
    public func pop() -> T? {
        return self.isEmpty ? nil : self.vals.removeAtIndex(self.count-1)
    }
    
    // SequenceType
    public func generate() -> AnyGenerator<T> {
        return anyGenerator{self.pop()}
    }
    
}
