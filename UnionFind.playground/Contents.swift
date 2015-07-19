import UIKit
import Studium
import XCPlayground


// Small network
print("Small Network")
// Union Find Quick Find
var file = XCPSharedDataDirectoryPath + "/tinyUF.txt"
var (nrows, connections) = Data.Connection.load(file)
print("nrows=\(nrows)")
var uf : UF  = UFQuickFind(count:nrows)
UFClient.connect(connections, uf:uf)
print("Quick Find number of Components: \(uf.count)")


// Union Find Quick Union
uf = UFQuickUnion(count:nrows)
UFClient.connect(connections, uf:uf)
print("Quick Union number of components: \(uf.count)")

// Union Find Weighted Quick Union
uf = UFWeightedQuickUnion(count:nrows)
UFClient.connect(connections, uf:uf)
print("Wieghted Quick Union: \(uf.count)")

// Medium Network
print("\nMedium Network")
// Union Find Quick Find
file = XCPSharedDataDirectoryPath + "/mediumUF.txt"
(nrows, connections) = Data.Connection.load(file)
print("nrows=\(nrows)")
uf = UFQuickFind(count:nrows)
UFClient.connect(connections, uf:uf)
print("Quick Find number of Components: \(uf.count)")

// Union Find Quick Union
uf = UFQuickUnion(count:nrows)
UFClient.connect(connections, uf:uf)
print("Quick Union number of components: \(uf.count)")

// Union Find Weighted Quick Union
uf = UFWeightedQuickUnion(count:nrows)
UFClient.connect(connections, uf:uf)
print("Wieghted Quick Union: \(uf.count)")


