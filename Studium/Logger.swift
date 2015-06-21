//
//  Logger.swift
//  BlueCap
//
//  Created by Troy Stribling on 6/8/14.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public class Logger {
    public class func debug(message:String? = nil, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
        #if DEBUG
            if let message = message {
            println("\(file):\(function):\(line): \(message)")
            } else {
            println("\(file):\(function):\(line)")
            }
        #endif
    }
    
}