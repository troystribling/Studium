//
//  Data.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public struct Data {
    
    enum TransactionError : ErrorType {
        case ParseError
    }
    
    public final class Transaction : Comparable, CustomStringConvertible {
        
        let who:String!
        let when:NSDate!
        let amount:Float!
        
        public class func load(file:String) -> [Transaction] {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            do {
                let data = try NSString(contentsOfFile:file, encoding:NSUTF8StringEncoding) as String
                let regex = try NSRegularExpression(pattern:"\\s+", options:[])
                let rows = split(data.characters){$0=="\n"}.map {slice -> [String] in
                    let row = NSMutableString()
                    row.setString(String(slice))
                    regex.replaceMatchesInString(row, options:[], range:NSMakeRange(0, row.length-1), withTemplate:",")
                    return split(String(row).characters){$0==","}.map(String.init)
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
            } catch {
                return []
            }
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

