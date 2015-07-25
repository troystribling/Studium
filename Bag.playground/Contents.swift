//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

// Bag
let bag = Bag<Int>()
print(bag.isEmpty)
print(bag.count)
bag.add(1)
bag.add(3)
bag.add(-1)
for i in bag {
    print(i)
}
print(bag.count)
print(bag.isEmpty)

