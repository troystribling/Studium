import UIKit
import Studium

var vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print(vals)
print(ArrayTools.sorted(vals))
Sort.Heap.sort(&vals)
print(vals)
print(ArrayTools.sorted(vals))