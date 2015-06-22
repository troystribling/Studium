import UIKit
import Studium

var vals = ArrayTools.fillRandom(10, upToValue:3)
println(vals)
Sort.Insertion.sort(&vals)
println(vals)
