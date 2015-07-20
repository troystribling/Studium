//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

// Selection Sort
print("Selection Sort")
var vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
Sort.Selection.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")

// Insertion Sort
print("\nInsertion Sort")
vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
Sort.Insertion.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")

// Shell Sort
print("\nShell Sort")
vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
Sort.Shell.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")

// Topdown Merge Sort
print("\nTopdown Merge Sort")
vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
Sort.Merge.TopDown.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")


// Bottom up Merge Sort
print("\nBottom Up Sort")
vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
Sort.Merge.BottomUp.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")


// Quick Sort
print("\nQuick Sort")
vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
Sort.Quick.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")

// 3Way Quick Sort
print("\n3Way Quick Sort")
var vals32 = ArrayTools.fillRandom(30, upToValue:4)
ArrayTools.shuffle(&vals32)
print("Presort:\(ArrayTools.sorted(vals32))")
Sort.Quick3way.sort(&vals32)
print("Postsort:\(ArrayTools.sorted(vals32))")

// Heap Sort
print("\nHeap Sort")
vals = ArrayTools.fillUpTo(30)
ArrayTools.shuffle(&vals)
print("Presort:\(ArrayTools.sorted(vals))")
Sort.Heap.sort(&vals)
print("Postsort:\(ArrayTools.sorted(vals))")
