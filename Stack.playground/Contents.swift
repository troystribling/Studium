//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

// Stack
let stack = Stack<Int>()
print(stack.isEmpty)
print(stack.count)
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
print(stack.count)
print(stack.isEmpty)
for i in stack {
    print(i)
}
print(stack.count)
print(stack.isEmpty)
