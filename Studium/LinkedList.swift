//
//  LinkedList.swift
//  Studium
//
//  Created by Troy Stribling on 7/12/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public class LinkedListNode<T> {
    public let item : T
    internal var next : LinkedListNode?
    public init(item:T, next:LinkedListNode?=nil) {
        self.item = item
        self.next = next
    }
}

public class LinkedList<T> : SequenceType {
    
    internal var first : LinkedListNode<T>?
    internal var last : LinkedListNode<T>?
    private var n : Int = 0
    
    public var size : Int {
        return self.n
    }
    
    public var isEmpty : Bool {
        return self.n == 0
    }
    
    public init() {
    }
    
    public func push(item:T) {
        let newNode = LinkedListNode(item:item)
        self.first?.next = newNode
        ++self.n
        self.first = newNode
        if self.isEmpty {
            self.last = newNode
        }
    }
    
    public func pop() -> T? {
        let oldNode = self.first
        self.first = oldNode?.next
        --self.n
        if self.isEmpty {
            self.last = nil
        }
        return oldNode?.item
    }
    
    public func enqueue(item:T) {
        let newNode = LinkedListNode(item:item)
        self.last?.next = newNode
        self.last = newNode
        ++self.n
    }
    
    public func dequeue() -> T? {
        return self.pop()
    }
    
    // SequenceType
    public func generate() -> LinkeListGenerator<T> {
        return LinkeListGenerator(list:self)
    }
}

public struct LinkeListGenerator<T> : GeneratorType {

    let list : LinkedList<T>
    var currentNode : LinkedListNode<T>?
    
    public init(list:LinkedList<T>) {
        self.list = list
        self.currentNode = list.first
    }
    
    public mutating func next() -> LinkedListNode<T>? {
        if let currentNode = self.currentNode {
            let node = currentNode
            self.currentNode = node.next
            return node
        } else {
            return nil
        }
    }
}
