import UIKit
import Studium

// Stack
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
