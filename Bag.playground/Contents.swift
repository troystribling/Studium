import UIKit
import Studium

// Bag
let bag = Bag<Int>()
print(bag.isEmpty)
print(bag.size)
bag.add(1)
bag.add(3)
bag.add(-1)
for i in bag {
    print(i)
}
print(bag.size)
print(bag.isEmpty)

