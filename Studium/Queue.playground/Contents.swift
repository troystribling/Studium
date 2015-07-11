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

// MaxPriorityQ
let maxPQ = MaxPriorityQ<Int>()
maxPQ.insert(5)
maxPQ.insert(7)
maxPQ.insert(1)
maxPQ.insert(-10)
maxPQ.insert(10)
print(maxPQ.delMax())
print(maxPQ.delMax())
print(maxPQ.delMax())
print(maxPQ.delMax())
print(maxPQ.delMax())
print(maxPQ.delMax())

// MinPriorityQ
let minPQ = MinPriorityQ<Int>()
minPQ.insert(5)
minPQ.insert(7)
minPQ.insert(1)
minPQ.insert(-10)
minPQ.insert(10)
print(minPQ.delMin())
print(minPQ.delMin())
print(minPQ.delMin())
print(minPQ.delMin())
print(minPQ.delMin())

// MinPriorityQ Transactions
let transactionFile = XCPSharedDataDirectoryPath + "/tinyBatch.txt"
let transactions = Data.Transaction.load(transactionFile)
PQClient.maxVals(transactions, nVals:5)

// MaxPriorityQ Transactions
PQClient.minVals(transactions, nVals:5)

