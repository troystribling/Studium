//
//  Stack.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation


public struct StackGenerator<T> : GeneratorType {
    let stack : Stack<T>
    public mutating func next() -> T? {
        return self.stack.pop()
    }
}

public class Stack<T> : SequenceType {
    
    internal var vals = [T]()

    public var isEmpty : Bool {
        return self.vals.count == 0
    }
    
    public var size : Int {
        return self.vals.count
    }
    
    public init() {
    }
    
    public func push(val:T) {
        self.vals.append(val)
    }
    
    public func pop() -> T? {
        return self.isEmpty ? nil : self.vals.removeAtIndex(self.size-1)
    }
    
    // SequenceType
    public func generate() -> StackGenerator<T> {
        return StackGenerator(stack:self)
    }
    
}