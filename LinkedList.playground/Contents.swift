//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

// Stack interface
print("Stack Interface")
let stack = LinkedList<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
print("prepop size=\(stack.size)")
if let item = stack.pop() {
    print("popped item=\(item)")
}
print("postpop size=\(stack.size)")
for item in stack {
    print(item)
}

// Queue interface
print("Queue Interface")
let queue = LinkedList<Int>()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)
print("pre dequeue size=\(queue.size)")
if let item = queue.dequeue() {
    print("dequed item=\(item)")
}
print("post dequeue size=\(queue.size)")
for item in queue {
    print(item)
}

// Mixed Interface access
print("Mixed Interface Access")
let mixed = LinkedList<Int>()
mixed.push(1)
mixed.push(2)
mixed.enqueue(3)
mixed.enqueue(4)
print("prepop size=\(mixed.size)")
if let item = mixed.pop() {
    print("popped item=\(item)")
}
print("post pop pre dequeue size=\(mixed.size)")
if let item = mixed.dequeue() {
    print("dequeued item=\(item)")
}
print("post dequeue size=\(mixed.size)")
for item in mixed {
    print(item)
}