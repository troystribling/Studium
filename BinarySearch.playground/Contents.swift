//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

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

let st = STBinarySearch(capacity:10, initialKey:0, initialValue:"")
st.put(1, value:"Troy")
st.put(2, value:"Stribling")
st.put(3, value:"Dr.")
print("Table: size: \(st.count)")
for key in st {
    if let value = st.get(key) {
        print("key=\(key), value=\(value)")
    }
}