//
//  BinarySearch.swift
//  Studium
//
//  Created by Troy Stribling on 7/26/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

// Binary search
// Find the index in values of key. values is assumed to be sorted
public struct BinarySearch {
    
    // return the index of key in values
    public static func rank<T:Comparable>(key:T, values:[T]) -> Int? {
        // initiate recursive calls that
        return self.rank(key, values:values, lo:0, hi:values.count-1)
    }
    
    // return the index of key in values where the range of indexes lies between lo and hi
    public static func rank<T:Comparable>(key:T, values:[T], lo:Int, hi:Int) -> Int? {
        // key not found
        guard lo <= hi else {
            return nil
        }
        // test mid as key rank
        let mid = lo + (hi - lo)/2
        if key < values[mid] {
            // rank is less than mid look to right for rank between lo and mid-1
            return self.rank(key, values:values, lo:lo, hi:mid - 1)
        } else if key > values[mid] {
            // rank is larger than mid look to left for rank between mid+1 and hi
            return self.rank(key, values:values, lo:mid+1, hi:hi)
        } else {
            // rank found
            return mid
        }
    }
}

// Iterate over all keys and values
public struct STBinarySearchGenerator<Key:Comparable, Value> : GeneratorType {
    
    let st : STBinarySearch<Key, Value>
    var i = 0
    
    init(st:STBinarySearch<Key, Value>) {
        self.st = st
    }
    
    public mutating func next() -> (Key, Value)? {
        if i < st.count {
            let key = st.keys[i]
            let value = st.values[i++]
            return (key, value)
        } else {
            return nil
        }
    }
}

// Symbol Table implemented with binary search
public class STBinarySearch<Key:Comparable, Value> : CollectionType, Indexable, SequenceType {
    
    // store keys in array and values in array indexed by key rank
    public var _keys : [Key]
    private var _values : [Value]
    public var n : Int = 0
    
    public init() {
        self._values = [Value]()
        self._keys = [Key]()
    }
    
    public init (capacity:Int, initialKey:Key, initialValue:Value) {
        self._values = [Value](count:capacity, repeatedValue:initialValue)
        self._keys = [Key](count:capacity, repeatedValue:initialKey)
    }
    
    // return keys
    public var keys : [Key] {
        return self._keys
    }
    
    // return values
    public var values : [Value] {
        return self._values
    }
    
    // return minimum key
    var min : Key? {
        if self.count > 0 {
            return self.keys[0]
        } else {
            return nil
        }
    }
    
    // return maximum key
    var max : Key? {
        if self.count > 0 {
            return self.keys[self.count-1]
        } else {
            return nil
        }
    }
    
    // get value for key
    public func get(key:Key) -> Value? {
        // table has no keys
        guard !self.isEmpty else {
            return nil
        }
        let i = self.rank(key)
        if i < self.n && self.keys[i] == key {
            // value found
            return self.values[i]
        } else {
            // value not found
            return nil
        }
    }
    
    // add value to symbol table with key
    public func updateValue(key:Key, value:Value) -> Value? {
        // rank is number of keys in self.keys less than key
        let i = self.rank(key)
        // key is in table. update value and do not increment count
        if i < self.count && self.keys[i] == key {
            let oldValue = self.values[i]
            self._values[i] = value
            return oldValue
        }
        // key is not in self.keys location in keys is i
        if i < self.keys.count {
            // need to make room for key. move all keys left by one position.
            for var j = self.count; j > i; --j {
                self._keys[j] = self.keys[j-1]
                self._values[j] = self.values[j-1]
            }
            self._keys[i] = key
            self._values[i] = value
        } else {
            // array capacity reached add key tp end of keys
            self._keys.append(key)
            self._values.append(value)
        }
        self.n++
        return nil
    }
    
    
    // remove value from symbol table
    public func removeValueForKey(key:Key) -> Value? {
        // rank of key is number of keys in self.keys less than key
        let i = self.rank(key)
        if i < self.count && key == self.keys[i] {
            // key is in table. remove value by moving keys and values and update count
            let value = self.values[i]
            for var j = i; i < self.count-1; ++j {
                self._values[j] = self.values[j+1]
                self._keys[j] = self.keys[j+1]
            }
            self.n--
            return value
        } else {
            // key not found. return nil
            return nil
        }
    }
    
    // return smallest key greater than or equal to key
    public func ceiling(key:Key) -> Key? {
        // rank returns the number of keys in self.keys less than key
        let i = self.rank(key)
        if let ceiling = self.select(i) where ceiling >= key {
            // if ceiling is found and is actual ceiling
            return ceiling
        } else {
            // no ceiling found
            return nil
        }
    }
    
    // return largest key less than or equal to key
    public func floor(key:Key) -> Key? {
        // rank returns the number of keys in self.keys less than key
        let i = self.rank(key)
        if i < self.count {
            // rank is existing index in self.keys
            if let floor = self.select(i) where i > 0 {
                // floor key exists and is not first key
                if floor == key {
                    // floor an key are equal
                    return floor
                } else {
                    // key is not in self.keys so floor is to left of rank
                    return self.select(i-1)
                }
            } else {
                // returned floor key is firstr key so it doe not exist
                return nil
            }
        } else {
            // rank is larger than any index in self.keys for floor is max key
            return self.max
        }
    }
    
    // return the number of keys in self.keys smaller than key. If key is in self.keys this will be the index
    // of key. If key is not in self.keys this will be the index key would have if it were in keys.
    public func rank(key:Key) -> Int {
        var lo = 0, hi = self.count - 1
        while lo <= hi {
            let mid = lo + (hi - lo)/2
            let testKey = self.keys[mid]
            if testKey > key {
                // key is smaller than test key look to right for rank between lo and mid-1
                hi = mid - 1
            } else if testKey < key {
                // key is larger than testKey look to left for rank between mid+1 and hi
                lo = mid + 1
            } else {
                // key found return rank
                return mid
            }
        }
        // no key found rank will be last value of lo. This follows since at previous step key was between
        // lo < key < mid where mid = lo + 1 since serach would have been exhaustive
        return lo
    }
    
    // return the key with the speficied rank
    public func select(rank:Int) -> Key? {
        if rank < self.count {
            return self.keys[rank]
        } else {
            return nil
        }
    }
    
    // retutn the index for ther specified key
    public func indexForKey(key:Key) -> Int? {
        if let rank = BinarySearch.rank(key, values:self.keys) {
            return rank
        } else {
            return nil
        }
    }
    
    // return interator over keys in range 
    public func keys(lo:Key, hi:Key) -> AnyGenerator<(Key, Value)> {
        var i = self.rank(lo)
        return anyGenerator{
            if let key = self.select(i) where key <= hi {
                let value = self.values[i++]
                return (key,  value)
            } else {
                return nil
            }
        }
    }
    
    // CollectionType
    public var count : Int {
        return self.n
    }
    
    public var isEmpty : Bool {
        return self.count == 0
    }
    
    public var first : (Key, Value)? {
        if self.count > 0 {
            return (self.keys[0], self.values[0])
        } else {
            return nil
        }
    }
    
    public var last : (Key, Value)? {
        if self.count > 0 {
            return (self.keys[self.count-1], self.values[self.count-1])
        } else {
            return nil
        }
    }
    
    public var startIndex : Int {
        return 0
    }
    
    public var endIndex : Int {
        return self.count
    }
    
    public subscript(position:Int) -> (Key, Value) {
        return (self.keys[position], self.values[position])
    }
    
    public func generate() -> STBinarySearchGenerator<Key, Value> {
        return STBinarySearchGenerator(st:self)
    }
    
}