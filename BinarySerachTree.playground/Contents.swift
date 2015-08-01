//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).

import UIKit
import Studium

let st = BST<Int, String>()

st.updateValue(10, value:"Troy")
st.updateValue(1, value:"Stribling")
st.updateValue(5, value:"Dr.")
st.updateValue(7, value:"William")
st.updateValue(3, value:"San Francisco")
st.updateValue(20, value:"Mission")
st.updateValue(15, value:"gnos.us")

st.minKey()
st.maxKey()

st.ceiling(20)
st.floor(16)
