import UIKit
import Studium

// Stack
print("Stack")
let stack = Stack<Int>()
print(stack.isEmpty)
print(stack.size)
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
print(stack.size)
print(stack.isEmpty)
for i in stack {
    print(i)
}
print(stack.size)
print(stack.isEmpty)

// Bag
print("Bag")
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
