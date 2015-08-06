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
public class BSTNode<Key:Comparable, Value> : CustomStringConvertible {
    
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
    
    // CustomStringConvertible
    public var description: String {
        return "\(self.key), \(self.value), \(self.count)"
    }
}

public enum BSTDirection {
    case Left, Right
}

public class BST<Key:Comparable, Value> : SequenceType  {
    
    private var root : BSTNode<Key, Value>?
    
    public init(root:BSTNode<Key, Value>) {
            self.root = root
    }
    
    public init(){}
    
    // return the minimum key
    public func minKey() -> Key? {
        return self.minNode(self.root)?.key
    }
    
    // the miminum key will be the key of the left most leaf node in the tree since for each node
    // the left child has the smaller key
    private func minNode(node:BSTNode<Key, Value>?) -> BSTNode<Key, Value>? {
        guard let node = node else {
            return nil
        }
        if let left = node.left {
            return self.minNode(left)
        } else {
            return node
        }
    }
    
    // return the maximum key will be the key of the right most leaf node in the tree since 
    // for each node the right child has the larger key
    public func maxKey() -> Key? {
        return self.maxNode(self.root)?.key
    }
    
    // the maximum key will be the righ most
    private func maxNode(node:BSTNode<Key, Value>?) -> BSTNode<Key, Value>? {
        guard let node = node else {
            return nil
        }
        if let right = node.right {
            return self.maxNode(right)
        } else {
            return node
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
    
    // return the key with the specified rank. rank is defined as the number of
    // keys smaller than a given key when the keys are ordered.
    public func select(rank:Int) -> Key? {
        guard rank <= self.count else {
            return nil
        }
        return self.select(self.root, rank:rank)
    }
    
    // traverse the tree looking for key with specified rank
    private func select(node:BSTNode<Key, Value>?, rank:Int) -> Key? {
        guard let node = node else {
            return nil
        }
        // get left subtree size
        let size = self.count(node.left)
        // if the left subtree is larger the key is to the left
        if size > rank {
            return self.select(node.left, rank:rank)
        // if the left subtree is smaller than rank so key will be in right subtree. rank of key relative to 
        // right subtree is rank - size 1
        } else if size < rank {
            return self.select(node.right, rank:rank - size - 1)
        // subtree rooted at node has size equal to rank so key with rank is node.key. This case occurs for
        // leaf nodes where size = 0 and nodes with only a left child where size = 1
        } else {
            return node.key
        }
    }
    
    // return the rank of the specified key. rank is defined as the number of keys less than a given
    // key when the keys are ordered
    public func rank(key:Key) -> Int {
        return self.rank(self.root, key:key)
    }
    
    // traverse the tree to determine the rank of he given key
    private func rank(node:BSTNode<Key, Value>?, key:Key) -> Int {
        guard let node = node else {
            return 0
        }
        // get left subtree size
        let size = self.count(node.left)
        
        // if key is smaller than node.key
        if key < node.key {
            let left_size = self.rank(node.left, key:key)
            return left_size
        // if key is larger than node.key
        } else if key > node.key {
            let right_size = self.rank(node.right, key:key)
            return size + 1 + right_size
        // if key == node.key the rank will be the size of the left tree
        } else {
            return size
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
            return nil
        }
        // check the left child if key is less than node.key
        if key < node.key {
            return self.getValueForKey(node.left, key:key)
        // check the right child if key is greater than node.key
        } else if key > node.key {
            return self.getValueForKey(node.right, key:key)
        } else {
        // node has specified key return node value
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
            return (BSTNode(key:key, value:value, count:1), nil)
        }
        // check the left child if key is less than node.key and reset child associations to pick up  changes
        let oldValue : Value?
        if key < node.key {
            (node.left, oldValue) = self.updateValue(node.left, key:key, value:value)
        // check the right child if key the greater than node.key and reset child associations to pick up changes
        } else if key > node.key {
            (node.right, oldValue) = self.updateValue(node.right, key:key, value:value)
        // node has specified key. update value
        } else {
            oldValue = node.value
            node.value = value
        }
        // update node count if node is added to subtree
        node.count = self.count(node.left) + self.count(node.right) + 1
        return (node, oldValue)
    }
    
    // remove the minimum value
    public func removeMinValue() {
        removeMinValue(self.root)
    }
    
    // traverse tree to minimum, the left most node, value and remove
    private func removeMinValue(node:BSTNode<Key, Value>?) -> BSTNode<Key, Value>? {
        guard let node = node else {
            return nil
        }
        // if left node is nil minimum value has been reached return right node
        guard let left = node.left else {
            print("node.key=\(node.key) has no left")
            return node.right
        }
        // to remove the node assign the right node of the removed node to the left node of the parent
        // this preserves the binary search tree constaint
        node.left = self.removeMinValue(left)
        node.count = self.count(left) + self.count(node.right)
        return node
    }
    
    // remove the maximum value
    public func removeMaxValue() {
        self.removeMaxValue(self.root)
    }
    
    // traverse tree to maximum, the right most node, and remove
    private func removeMaxValue(node:BSTNode<Key, Value>?) -> BSTNode<Key, Value>? {
        guard let node = node else {
            return nil
        }
        // if right node is nil maximum value has been reached return the left node
        guard let right = node.right else {
            return node.left
        }
        // to remove the node assign the left node of the removed node to the right node of the parent
        // this preserves the binary serach tree constaint
        node.right = self.removeMaxValue(right)
        node.count = self.count(right) + self.count(node.left)
        return node
    }
    
    // remove the node with the specified key and return the value of the node if found.
    // return nil if no node with key is found.
    public func removeValueForKey(key:Key) {
        self.removeValueForKey(self.root , key:key)
    }

    private func removeValueForKey(node:BSTNode<Key, Value>?, key:Key) -> BSTNode<Key, Value>? {
        guard let node = node else {
            return nil
        }
        print("key=\(key), node.key=\(node.key)")
        // key is smaller than node.key look deeper left in tree for node to delete. if left node is to be deleted
        // it is removed ressigning left node reference
        if key < node.key {
            print("key < node.key go left")
            node.left = self.removeValueForKey(node.left, key:key)
            return node
        // key is larger than node.key look deeper right in ytree for node to delete
        } else if key > node.key {
            print("key > node.key go right")
            node.right = self.removeValueForKey(node.right, key:key)
            return node
        // node with key found remove
        } else {
            // node has no right node it is a subtree maximum. node is removed by assigning removed node left
            // to parent node right. this change perserves binray search tree order
            if node.right == nil {
                return node.left
            }
            // node has no left node it is a subtree minimum. node is removed by assigninhg removed node right
            // to parent node right. this change preserves binary search tree order
            if node.left == nil {
                return node.right
            }
            // node is not a subtree minimum or maximum to remove node and preserve binary search tree order
            // first find the minimum value for the subtree rooted at node.right. This node will replace
            // the removed node
            if let replacement_node = self.minNode(node.right) {
                // remove the the replement node from the subtree rooted at node.right
                replacement_node.right = self.removeMinValue(node.right)
                replacement_node.left = node.left
                return replacement_node
            } else {
                return nil
            }
        }
    }
    
    // print nodes in sort order
    public func printSortOrder() {
        self.sortOrderIterate {node in
            print(node)
        }
    }
    
    // print nodes in post porder
    public func printPostOrder() {
        self.postOrderIterate {node in
            print(node)
        }
    }
    
    // traverse tree in sort order and do something
    public func sortOrderIterate(f:BSTNode<Key, Value> -> Void) {
        self.sortOrderIterate(self.root, f:f)
    }
    
    public func sortOrderIterate(node:BSTNode<Key, Value>?, f:BSTNode<Key, Value> -> Void) {
        guard let node = node else {
            return
        }
        // go left until subtree minimum is reached
        self.sortOrderIterate(node.left, f:f)
        // do thing
        f(node)
        // go right
        self.sortOrderIterate(node.right, f:f)
    }
    
    // traverse tree in post order and do something
    public func postOrderIterate(f:BSTNode<Key, Value> -> Void) {
        self.postOrderIterate(self.root, f:f)
    }
    
    private func postOrderIterate(node:BSTNode<Key, Value>?, f:BSTNode<Key, Value> -> Void) {
        guard let node = node else {
            return
        }
        self.postOrderIterate(node.left, f:f)
        self.postOrderIterate(node.right, f:f)
        f(node)
    }
    
    // return the maximum tree height
    public func maxHeight() -> Int {
        return self.maxHeight(self.root)
    }
    
    // traverse tree to determine maximum height
    private func maxHeight(node:BSTNode<Key, Value>?) -> Int {
        guard let node = node else {
            return 0
        }
        let left_height = self.maxHeight(node.left)
        let right_height = self.maxHeight(node.right)
        return left_height > right_height ? (left_height + 1) : (right_height + 1)
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

    public func generate() -> AnyGenerator<(Key, Value)> {
        return anyGenerator {
            return nil
        }
    }
    
}