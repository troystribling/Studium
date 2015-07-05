//: Playground - noun: a place where people can play

import UIKit
import Studium
import XCPlayground

let transactionFile = XCPSharedDataDirectoryPath + "/tinyBatch.txt"
let vals = Data.Transaction.load(transactionFile)
