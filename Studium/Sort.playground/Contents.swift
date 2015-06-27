import UIKit
import Studium

var vals = ArrayTools.fillReversedUpTo(7)
println(vals)
Sort.Merge.TopDown.sort(&vals)
println(vals)

