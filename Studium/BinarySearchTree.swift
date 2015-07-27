//
//  BinarySearchTree.swift
//  Studium
//
//  Created by Troy Stribling on 7/26/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public class BSTNode<Key:Comparable, Value> {
    
    internal var key    : Key
    internal var value  : Value
    internal var count  : Int
    internal var left   : BSTNode<Key, Value>?
    internal var right  : BSTNode<Key, Value>?
    
    internal init(key:Key, value:Value, count:Int) {
        self.key = key
        self.value = value
        self.count = count
    }
}

public class BST<Key:Comparable, Value> {
    
    private var root : BSTNode<Key, Value>?
    
    public var count : Int {
        if let root = self.root {
            return root.count
        } else {
            return 0
        }
    }
    
    private func count(node:BSTNode<Key, Value>?) -> Int {
        if let node = node {
            return node.count
        } else {
            return 0
        }
    }
    
    public func getValueForKey(key:Key) -> Value? {
        return self.getValueForKey(self.root, key:key)
    }
    
    private func getValueForKey(node:BSTNode<Key, Value>?, key:Key) -> Value? {
        guard let node = node else {
            return nil
        }
        if key < node.key {
            return self.getValueForKey(node.left, key:key)
        } else if key > node.key {
            return self.getValueForKey(node.right, key:key)
        } else {
            return node.value
        }
    }
    
    public func updateValue(key:Key, value:Value) -> Value? {
        return nil
    }
    
    public func updateValue(node:BSTNode<Key, Value>?, key:Key, value:Value) -> BSTNode<Key, Value>? {
        return nil
    }
    
    public func removeValueForKey(key:Key) -> Value? {
        return nil
    }
}