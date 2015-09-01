//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

// Selection Sort
print("Merge1 Sort")
var vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
MergeSort1.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")

print("Merge2 Sort")
vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
MergeSort2.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")

