import UIKit
import Studium
import XCPlayground

let file = XCPSharedDataDirectoryPath + "/tinyUF.txt"
let (nrows, connections) = Data.Connection.load(file)

