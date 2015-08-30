//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit

func fizbaz() {
    for i in (1...100) {
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




