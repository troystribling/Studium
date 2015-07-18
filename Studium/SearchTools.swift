//
//  SearchTools.swift
//  Studium
//
//  Created by Troy Stribling on 7/12/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct UFClient {
    
    public static func connect(connections:[Data.Connection], uf:UnionFind) {
        for connection in connections {
            if !uf.connected(connection.p, q:connection.q) {
                uf.union(connection.p, q:connection.q)
            }
        }
    }
}