//
//  BinarySearchTree.swift
//  Studium
//
//  Created by Troy Stribling on 7/26/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

// Binary Search Tree
// A binary tree consists of a network of nodes containing a key and value each of which has has two children,
// referred to as the left and right child. The tree has a single root node and every node in the tree is also the 
// root of a binary subtree tree. There is also the constraint on the node keys that all keys of all nodes in the 
// left subtree are less than the node key and the keys of all nodes in the right subtree are greater 
// than the node key.

// Binary Serach Tree Node
public class BSTNode<Key:Comparable, Value> {
    
    // node key
    internal var key    : Key
    // node value
    internal var value  : Value
    // number of nodes in subtree including node
    internal var count  : Int
    // left child node satisfying left.key < key
    internal var left   : BSTNode<Key, Value>?
    // right child node satisfying right.key > key
    internal var right  : BSTNode<Key, Value>?
    
    internal init(key:Key, value:Value, count:Int) {
        self.key = key
        self.value = value
        self.count = count
    }
}

public enum BSTDirection {
    case Left, Right
}

public class BST<Key:Comparable, Value> {
    
    private var root : BSTNode<Key, Value>?
    
    public init(){}
    
    // return the minimum key
    public func minKey() -> Key? {
     return self.minKey(self.root)
    }
    
    // the miminum key will be the key of the left most leaf node in the tree since for each node
    // the left child has the smaller key
    private func minKey(node:BSTNode<Key, Value>?) -> Key? {
        guard let node = node else {
            return nil
        }
        if let left = node.left {
            return self.minKey(left)
        } else {
            return node.key
        }
    }
    
    // return the maximum key will be the key of the right most leaf node in the tree since 
    // for each node the right child has the larger key
    public func maxKey() -> Key? {
        return self.maxKey(self.root)
    }
    
    // the maximum key will be the righ most
    private func maxKey(node:BSTNode<Key, Value>?) -> Key? {
        guard let node = node else {
            return nil
        }
        if let right = node.right {
            return self.maxKey(right)
        } else {
            return node.key
        }
    }
    
    // return the ceiling of the specified key defined as the smallest node.key
    // greater than or equal to key
    public func ceiling(key:Key) -> Key? {
        guard let maxKey = self.maxKey(), root = self.root where key <= maxKey else {
            return nil
        }
        return self.ceiling(root, key:key, value:maxKey)
    }
    
    // traverse the tree searching for ceiling
    private func ceiling(node:BSTNode<Key, Value>?, key:Key, value:Key) -> Key {
        guard let node = node else {
            return value
        }
        // key is smaller check left for smaller ceiling and upadate current value
        if key < node.key {
            let newValue = node.key < value ? node.key : value
            return self.ceiling(node.left, key:key, value:newValue)
        // key is larger check right for larger ceiling
        } else if key > node.key {
            return self.ceiling(node.right, key:key, value:value)
        // key and node.key are equal so node.key is ceiling
        } else {
            return node.key
        }
    }
    
    // return the floor of the specified key defined as the largest node.key
    // less than or equal to key
    public func floor(key:Key) -> Key? {
        guard let minKey = self.minKey(), root = self.root where key >= self.minKey() else {
           return nil
        }
        return floor(root, key:key, value:minKey)
    }
    
    // traverse tree looking for floor
    private func floor(node:BSTNode<Key, Value>?, key:Key, value:Key) -> Key? {
        guard let node = node else {
            return value
        }
        // key is smaller check left for smaller floor
        if key < node.key {
            return self.floor(node.left, key:key, value:value)
        // key is larger check right for larger floor and update current value
        } else if key > node.key {
            let newValue = node.key > value ? node.key : value
            return self.floor(node.right, key:key, value:newValue)
        // key equals node.key floor is node.key
        } else {
            return node.key
        }
    }
    
    // return the count of the specified nodes subtree
    private func count(node:BSTNode<Key, Value>?) -> Int {
        if let node = node {
            return node.count
        } else {
            return 0
        }
    }
    
    // return the value of the node with the specified key
    public func getValueForKey(key:Key) -> Value? {
        return self.getValueForKey(self.root, key:key)
    }
    
    // return the value of the specified node if node.key = key otherwise go deeper in the tree
    private func getValueForKey(node:BSTNode<Key, Value>?, key:Key) -> Value? {
        guard let node = node else {
            print("node is nil: key=\(key)")
            return nil
        }
        print("key=\(key), node.key=\(node.key), node.value=\(node.value)")
        // check the left child if key is less than node.key
        if key < node.key {
            print("key < node.key go left")
            return self.getValueForKey(node.left, key:key)
        // check the right child if key is greater than node.key
        } else if key > node.key {
            print("key > node.key go right")
            return self.getValueForKey(node.right, key:key)
        } else {
        // node has specified key return node value
            print("key==node.key")
            return node.value
        }
    }
    
    // update the value of the node with specified key. If no node has key create
    // a new node with specified key and value.
    public func updateValue(key:Key, value:Value) -> Value? {
        let (node, value) = self.updateValue(self.root, key:key, value:value)
        self.root = node
        return value
    }
    
    // update the the value of the specified node if key = node.key otherwise search deeper in the tree.
    // if no node with with key is found create a new node
    private func updateValue(node:BSTNode<Key, Value>?, key:Key, value:Value) -> (BSTNode<Key, Value>?, Value?) {
        guard let node = node else {
            print("creating node: key=\(key), value=\(value)")
            return (BSTNode(key:key, value:value, count:1), nil)
        }
        // check the left child if key is less than node.key and reset child associations to pick up  changes
        print("key=\(key), node.key=\(node.key), node.value=\(node.value)")
        let oldValue : Value?
        if key < node.key {
            print("key < node.key go left")
            (node.left, oldValue) = self.updateValue(node.left, key:key, value:value)
        // check the right child if key the greater than node.key and reset child associations to pick up changes
        } else if key > node.key {
            print("key > node.key go right")
            (node.right, oldValue) = self.updateValue(node.right, key:key, value:value)
        // node has specified key. update value
        } else {
            print("key==node.key")
            oldValue = node.value
            node.value = value
        }
        // update node count if node is added to subtree
        node.count = self.count(node.left) + self.count(node.right)
        print("updated size: \(node.count)")
        return (node, oldValue)
    }
    
    // remove the node with the specified key and return the value of the node if found.
    // return nil if no node with key is found.
    public func removeValueForKey(key:Key) -> Value? {
        return nil
    }

    // CollectionType
    // return the count of nodes in tree which will be the root node count
    public var count : Int {
        if let root = self.root {
            return root.count
        } else {
            return 0
        }
    }
    
    public var isEmpty : Bool {
        return self.count == 0
    }

}