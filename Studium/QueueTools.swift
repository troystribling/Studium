//
//  QueueTools.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct PQClient {
    
    public static func topVals<T where T:Comparable>(items:[T], nVals:Int) {
        let pq = MinPriorityQ<T>()
        for item in items {
            pq.insert(item)
            if pq.size > nVals {
                pq.delMin()
            }
        }
        let minvals = Stack<T>()
        while(!pq.isEmpty) {
            if let minVal = pq.delMin() {
                minvals.push(minVal)
            }
        }
        for minVal in minvals {
            print(minVal)
        }
    }
    
}