//
//  LinkedList.swift
//  Studium
//
//  Created by Troy Stribling on 7/12/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

// node in linked list containing node item and reference to next node in list
public class LinkedListNode<T> {
    public let item : T
    internal var next : LinkedListNode?
    public init(item:T, next:LinkedListNode?=nil) {
        self.item = item
        self.next = next
    }
}

// linked list implementaion combining stack and queue interfaces to add and remove items form list
public class LinkedList<T> : SequenceType {
    
    // refernec to first node in list
    internal var first : LinkedListNode<T>?
    
    // refernce to last node in list
    internal var last : LinkedListNode<T>?
    
    // number of node in list
    private var n : Int = 0
    
    public var size : Int {
        return self.n
    }
    
    public var isEmpty : Bool {
        return self.n == 0
    }
    
    public init() {
    }
    
    // Add item to begging of list. Create a new node using given item and set its next reference
    // to currect first node then reassign first reference to new node. If the list is empty also set the 
    // reference to the last node in the list to the new node.
    public func push(item:T) {
        let newNode = LinkedListNode(item:item)
        newNode.next = self.first
        self.first = newNode
        if self.isEmpty {
            self.last = newNode
        }
        ++self.n
    }
    
    // Remove first item from list. Reassign the first node to the removed node next reference. If removing the node
    // empties the list set the reference to the last node to nil.
    public func pop() -> T? {
        let oldNode = self.first
        self.first = oldNode?.next
        if self.isEmpty {
            self.last = nil
        }
        --self.n
        return oldNode?.item
    }
    
    // Add an item to the end of the list. Save the current first node then reassign the first node to a newly created
    // node using the gevin item. If the list is empty set the refrence to the first node to the last node. If the list
    // is not empty assign the next node reference of the previous last not to the new last node.
    public func enqueue(item:T) {
        let oldlast = self.last
        self.last = LinkedListNode(item:item)
        if self.isEmpty {
            self.first = self.last
        } else {
            oldlast?.next = self.last
        }
        ++self.n
    }
    
    // Remove item from beginning of list. Implementaion is the same as pop
    public func dequeue() -> T? {
        return self.pop()
    }
    
    // SequenceType
    public func generate() -> LinkeListGenerator<T> {
        return LinkeListGenerator(list:self)
    }
}

// Linked list generator
public struct LinkeListGenerator<T> : GeneratorType {

    let list : LinkedList<T>
    var currentNode : LinkedListNode<T>?
    
    public init(list:LinkedList<T>) {
        self.list = list
        self.currentNode = list.first
    }
    
    public mutating func next() -> T? {
        if let currentNode = self.currentNode {
            let node = currentNode
            self.currentNode = node.next
            return node.item
        } else {
            return nil
        }
    }
}
