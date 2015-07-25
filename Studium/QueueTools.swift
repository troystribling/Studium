//
//  QueueTools.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public struct PQClient {
    
    public static func maxVals<T:Comparable>(vals:[T], nVals:Int) {
        let pq = MinPriorityQ<T>()
        for val in vals {
            pq.insert(val)
            if pq.count > nVals {
                pq.delMin()
            }
        }
        let minVals = Stack<T>()
        while(!pq.isEmpty) {
            if let minVal = pq.delMin() {
                minVals.push(minVal)
            }
        }
        print("\n\(nVals) Maximum Values")
        for minVal in minVals {
            print(minVal)
        }
    }

    public static func minVals<T:Comparable>(vals:[T], nVals:Int) {
        let pq = MaxPriorityQ<T>()
        for val in vals {
            pq.insert(val)
            if pq.count > nVals {
                pq.delMax()
            }
        }
        let maxVals = Stack<T>()
        while !pq.isEmpty {
            if let maxVal = pq.delMax() {
                maxVals.push(maxVal)
            }
        }
        print("\n\(nVals) Minimum Values")
        for maxVal in maxVals {
            print(maxVal)
        }
    }
}