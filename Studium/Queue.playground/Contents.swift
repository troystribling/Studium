//: Playground - noun: a place where people can play

import UIKit
import Studium
import XCPlayground

// queue interator
let queue = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)
queue.enqueue(4)
for i in queue {
    print(i)
}
queue.isEmpty

// Priority queue
let transactionFile = XCPSharedDataDirectoryPath + "/tinyBatch.txt"
let vals = Data.Transaction.load(transactionFile)
vals[1] > vals[0]
