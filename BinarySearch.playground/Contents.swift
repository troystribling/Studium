//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

// Binary Search
print("Binary Search")
var vals = [2,5,9,10,11,14,18,20]
// value found
if let val = BinarySearch.rank(10, values:vals) {
    print("rank found:\(val)")
} else {
    print("Error value not found")
}
// value not found
if BinarySearch.rank(15, values:vals) == nil {
    print("value not found")
} else {
    print("Error: value found")
}

print("\nBinary Search Symbol Table")
// Symbol table implemented with Binary Search
let st = STBinarySearch<Int, String>(capacity:10, initialKey:0, initialValue:"")

// build symbol table
print("Build Symbol Table")
st.updateValue(0, value:"Dr.")
st.updateValue(2, value:"William")
st.updateValue(4, value:"Stribling")
st.updateValue(5, value:"Mission")
st.updateValue(7, value:"San Francisco")
st.updateValue(10, value:"CA")
if st.count == 6 {
    print("count=\(st.count)")
} else {
    print("Count is invalid")
}
for (key, value) in st {
    print("key=\(key), value=\(value)")
}

// updating values
print("\nUpdate Values")
st.updateValue(2, value:"Troy")
for (key, value) in st {
    print("key=\(key), value=\(value)")
}

// get value
print("\nget Value")
if let value = st.getValueForKey(7) {
    print("\(value)")
}

// remove value
print("\nRemove Value")
st.removeValueForKey(10)
if st.count == 5 {
    print("count=\(st.count)")
} else {
    print("Count is invaliud")
}
for (key, value) in st {
    print("key=\(key), value=\(value)")
}

// iterators
print("\nReverse Interator")
for (key, value) in st.reverse() {
    print("key=\(key), value=\(value)")
}
print("\nRange Interator")
for (key, value) in st.keys(1, hi:6) {
    print("key=\(key), value=\(value)")
}

// index subscripts
print("\nIndex Access")
let (k, v) = st[2]
print("key=\(k), value=\(v)")


