//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit

// fizbaz
func fizbaz() {
    for i in (1...30) {
        if i % 15 == 0 {
            print("FizBaz")
        } else if i % 5 == 0 {
            print("Baz")
        } else if i % 3 == 0 {
            print("Fiz")
        }
    }
}

fizbaz()

// swap values
func swap<T>(inout v1:T, inout with:T)  {
    (with, v1) = (v1, with)
}

var v1 = 1
var v2 = 2
swap(&v1, with:&v2)
print("v1=\(v1), v2=\(v2)")


// count any
func countAnys(anys:Any...) -> String {
    return String(anys.count)
}

countAnys("Hey", 1,2,4,5,7)

// upto
func count(from:Int, upTo:Int) {
    print(from)
    guard upTo > from else {
        return
    }
    count(from+1, upTo:upTo)
}

count(1, upTo:5)