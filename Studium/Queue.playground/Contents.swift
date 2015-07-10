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
let transactions = Data.Transaction.load(transactionFile)
PQClient.topVals([10,5,4,20,6,8], nVals:2)