import UIKit
import Studium

var vals = ArrayTools.fillRandom(20, upToValue:4)
print(vals)
Sort.Quick3way.sort(&vals)
print(vals)
print(ArrayTools.sorted(vals))

func test(var x:Int) -> Int {
    ++x
    return x
}
