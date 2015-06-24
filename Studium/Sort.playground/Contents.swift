import UIKit
import Studium

var vals = ArrayTools.fillUpTo(20)
ArrayTools.shuffle(&vals)
println(vals)
Sort.Shell.sort(&vals)
ArrayTools.sorted(vals)
println(vals)

