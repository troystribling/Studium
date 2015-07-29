//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

let st = BST<Int, String>()

st.updateValue(5, value:"Troy")
st.updateValue(1, value:"Stribling")
st.updateValue(10, value:"Dr.")
st.updateValue(5, value:"William")
st.getValueForKey(1)