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
    public func minKey(node:BSTNode<Key, Value>?) -> Key? {
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
    public func maxKey(node:BSTNode<Key, Value>?) -> Key? {
        guard let node = node else {
            return nil
        }
        if let right = node.right {
            return self.maxKey(right)
        } else {
            return node.key
        }
    }
    
    // return the ceiling of the specified key defined as the smallest key 
    // greater than or equal to key
    public func ceiling(key:Key) -> Key? {
        guard let root = self.root else {
            return nil
        }
        // if key is smaller than root key ceiling is on the left side of tree
        if key < root.key {
            return self.ceiling(self.root, key:key, direction:BSTDirection.Left)
        // if key is larger than root key ceiling is on the right side of tree
        } else if key > root.key {
            return self.ceiling(self.root, key:key, direction:BSTDirection.Right)
        // if key is equal root root key is ceiling
        } else {
            return root.key
        }
    }
    
    // traverse the tree looking for the ceiling.
    public func ceiling(node:BSTNode<Key, Value>?, key:Key, direction:BSTDirection) -> Key? {
        guard let node = node else {
            print("node is nil")
            return nil
        }
        print("key=\(key), node.key=\(node.key)")
        switch direction {
        // traversing left side of tree
        case BSTDirection.Left:
            print("BSTDirection.Left")
            // key is still smaller than node key go deeper left in tree
            if key < node.key {
                print("go deeper to left key=\(key) < node.key=\(node.key)")
                return self.ceiling(node.left, key:key, direction:BSTDirection.Left)
            // key is larger may have found ceiling
            } else if key > node.key {
                print("key=\(key) > node.key=\(node.key)")
                if let right = node.right {
                    // key is larger still ceiling is deeper in right subtree
                    if key > right.key {
                        print("go deeper to right key = \(key) > right.key = \(right.key)")
                        return self.ceiling(node.right, key:key, direction:BSTDirection.Right)
                    // key is less tahn are qual to right.key ceiling is right key
                    } else {
                        print("ceiling is right.key = \(right.key)")
                        return right.key
                    }
                // cannot go deeper node.key is ceiling
                } else {
                    print("right child is nil ceiling is node.key = \(node.key)")
                    return node.key
                }
            // key and node key are equal
            } else {
                print("ceiling is node.key key=\(key) == node.key=\(node.key)")
                return node.key
            }
        // traversing right side of tree
        case BSTDirection.Right:
            print("BSTDirection.Right")
            // key is larger still go deeper in right
            if key > node.key {
                print("go deeper to right key=\(key) > node.key=\(node.key)")
                return self.ceiling(node.right, key:key, direction:BSTDirection.Right)
            // key is smaller may have found ceiling
            } else if key < node.key {
                print("key=\(key) < node.key=\(node.key)")
                if let left = node.left {
                    // key is smaller still ceiling is deeper in left subtree
                    if key < left.key {
                        print("go deeper to left key = \(key) < left.key = \(left.key)")
                        return self.ceiling(node.left, key:key, direction:BSTDirection.Left)
                    // key is greater than left.key node.key is ceiling
                    } else if key > left.key {
                        print("ceiling is node.key key = \(key) > left.key = \(left.key)")
                        return node.key
                    // key equals left.key key is ceiling
                    } else {
                        print("ceiling is left.key = \(left.key)")
                        return left.key
                    }
                // cannot go deeper node.key is ceiling
                } else {
                    print("right child is nil ceiling is node.key = \(node.key)")
                    return node.key
                }
            // key and node key are equal
            } else {
                print("ceiling is node.key key=\(key) == node.key=\(node.key)")
                return node.key
            }
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
    public func updateValue(node:BSTNode<Key, Value>?, key:Key, value:Value) -> (BSTNode<Key, Value>?, Value?) {
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