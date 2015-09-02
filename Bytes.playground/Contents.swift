//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
import UIKit

let a = 0b100

print(String(0b100000000 >> 2, radix:2))


func largestPower(val:UInt64) -> (UInt64, Int) {
    var mask = UInt64(pow(2.0, 63))
    var result : UInt64 = 0
    var p = 63
    for _ in (0..<64) {
        result = mask & val
        if result > 0 {
            break
        }
        mask >>= UInt64(1)
        p--
    }
    return (result, p)
}

largestPower(34576274567994)

func isPowerOf2(val:UInt64) -> Bool {
    var mask = UInt64(pow(2.0, 63))
    for _ in (0..<63) {
        if mask == val {
            return true
        }
        mask >>= UInt64(1)
    }
    return false
}

isPowerOf2(17_592_186_044_416)
