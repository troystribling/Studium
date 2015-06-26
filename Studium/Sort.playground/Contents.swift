import UIKit
import Studium

var vals = ArrayTools.fillRandom(20, upToValue:5)
ArrayTools.shuffle(&vals)
println(vals)
println(ArrayTools.sorted(vals))
Sort.MergeTopDown.sort(&vals)
println(vals)
println(ArrayTools.sorted(vals))
