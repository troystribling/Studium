//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
import UIKit

// is number
func isNumber(val:String) -> Bool {
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var count = 0
    for chr in val.characters {
        if numbers.contains(String(chr)) {
            ++count
            if count == val.characters.count {
                return true
            }
        } else {
            return false
        }
    }
    return false
}

isNumber("67623")
isNumber("23677g")
isNumber("troy")
