//
//  Data.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct Data {
    
    public class Transaction : Comparable {
        
        let who:String, when:NSDate, amount:Float
        
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
        
//        public convenience init?(row:String) {
//            let dateFormatter = NSDateFormatter()
//            dateFormatter.dateFormat = "MM/dd/yyyy"
//            let mutableRow = NSMutableString()
//            mutableRow.setString(row)
//            do {
//                let regex = try NSRegularExpression(pattern:"\\s+", options:[])
//                regex.replaceMatchesInString(mutableRow, options:[], range:NSMakeRange(0, mutableRow.length-1), withTemplate:",")
//                let items = split(String(row).characters){$0==","}.map(String.init)
//                if items.count == 3 {
//                    if let when = dateFormatter.dateFromString(items[1]), amount = Float(items[2]) {
//                        self.init(who:items[0], when:when, amount:amount)
//                    }
//                }
//            } catch {
//                return nil
//            }
//
//        }
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

