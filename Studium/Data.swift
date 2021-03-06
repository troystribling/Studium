//
//  Data.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public struct Data {
    
    public final class Transaction : Comparable, CustomStringConvertible {
        
        let who:String!
        let when:NSDate!
        let amount:Float!
        
        public class func load(file:String) -> [Transaction] {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let data = try! NSString(contentsOfFile:file, encoding:NSUTF8StringEncoding) as String
            let regex = try! NSRegularExpression(pattern:"\\s+", options:[])
            let rows = data.characters.split{$0=="\n"}.map {slice -> [String] in
                let row = NSMutableString()
                row.setString(String(slice))
                regex.replaceMatchesInString(row, options:[], range:NSMakeRange(0, row.length-1), withTemplate:",")
                return String(row).characters.split{$0==","}.map(String.init)
            }
            var trans = [Transaction]()
            for row in rows {
                if row.count == 3 {
                    if let date = dateFormatter.dateFromString(row[1]), amount = Float(row[2]) {
                        trans.append(Transaction(who:row[0], when:date, amount:amount))
                    }
                }
            }
            return trans
        }
        
        public init(who:String, when:NSDate, amount:Float) {
            self.who = who
            self.amount = amount
            self.when = when
        }
        
        // CustomStringConvertible
        public var description: String {
            return "who:\(self.who), when:\(self.when), amount:\(self.amount)"
        }
    }
    
    public struct Connection : CustomStringConvertible {
        let p : Int
        let q : Int
        
        public static func load(file:String) -> (Int, [Connection]) {
            let data = try! NSString(contentsOfFile:file, encoding:NSUTF8StringEncoding) as String
            let rows = data.characters.split{$0=="\n"}
            if rows.count > 2 {
                if let nrows = Int(String(rows[0])) {
                    var connections = [Connection]()
                    for row in rows[1..<rows.count] {
                        let pqs = String(row).characters.split{$0==" "}.map(String.init)
                        if pqs.count >= 2 {
                            if let p = Int(pqs[0]), q = Int(pqs[1]) {
                                connections.append(Connection(p:p, q:q))
                            }
                        }
                    }
                    return (nrows, connections)
                } else {
                    return (0,[])                    
                }
            } else {
                return (0,[])
            }
        }
        
        // CustomStringConvertible
        public var description : String {
            return "[p:\(p), q:\(q)]"
        }
        
    }
}

// equitable
public func ==(lhs:Data.Transaction, rhs:Data.Transaction) -> Bool {
    return lhs.amount == rhs.amount
}

// comparable
public func <(lhs:Data.Transaction, rhs:Data.Transaction) -> Bool {
    return lhs.amount < rhs.amount
}

public func <=(lhs:Data.Transaction, rhs:Data.Transaction) -> Bool {
    return lhs.amount <= rhs.amount
}

public func >=(lhs:Data.Transaction, rhs:Data.Transaction) -> Bool {
    return lhs.amount >= rhs.amount
}

public func >(lhs:Data.Transaction, rhs:Data.Transaction) -> Bool {
    return lhs.amount > rhs.amount
}

