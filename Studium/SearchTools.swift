//
//  SearchTools.swift
//  Studium
//
//  Created by Troy Stribling on 7/12/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public struct UFClient {
    
    public static func connect(connections:[Data.Connection], uf:UF) {
        for connection in connections {
            uf.union(connection.p, q:connection.q)
        }
    }
}