//
//  Data.swift
//  Studium
//
//  Created by Troy Stribling on 7/4/15.
//  Copyright © 2015 gnos.us. All rights reserved.
//

import Foundation

public struct Data {
    
    public class Transaction {
        
        let name:String, amount:Float, date:NSDate
        
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
                            trans.append(Transaction(name:row[0], date:date, amount:amount))
                        }
                    }
                }
                return trans
            } catch {
                return []
            }
        }
        
        public init(name:String, date:NSDate, amount:Float) {
            self.name = name
            self.amount = amount
            self.date = date
        }
        
    }
    
}
