import UIKit
import Studium
import XCPlayground


// Union Find Quick Find
var file = XCPSharedDataDirectoryPath + "/tinyUF.txt"
var (nrows, connections) = Data.Connection.load(file)
var uf = UnionQuickFind(n:nrows)
UFClient.connect(connections, uf:uf)
print("Number of Components:\(uf.count)")


// Union Find Quick Union