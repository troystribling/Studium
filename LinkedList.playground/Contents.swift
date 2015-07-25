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
print("prepop size=\(stack.count)")
if let item = stack.pop() {
    print("popped item=\(item)")
}
print("postpop size=\(stack.count)")
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
print("pre dequeue size=\(queue.count)")
if let item = queue.dequeue() {
    print("dequed item=\(item)")
}
print("post dequeue size=\(queue.count)")
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
print("prepop size=\(mixed.count)")
if let item = mixed.pop() {
    print("popped item=\(item)")
}
print("post pop pre dequeue size=\(mixed.count)")
if let item = mixed.dequeue() {
    print("dequeued item=\(item)")
}
print("post dequeue size=\(mixed.count)")
for item in mixed {
    print(item)
}
