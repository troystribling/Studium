//
//  QueueTools.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct PQClient<T where T:Comparable, T:Loadable > {
    
    public static func topVals(file:String, nVals:Int) {
        let pq = MinPriorityQ<T>()
        for item in T.load(file) {
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
        
    }
    
}