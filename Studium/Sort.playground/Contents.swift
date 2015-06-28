import UIKit
import Studium

var vals = ArrayTools.fillRandom(20, upToValue:5)
print(vals)
Sort.Quick.sort(&vals)
print(vals)
print(ArrayTools.sorted(vals))