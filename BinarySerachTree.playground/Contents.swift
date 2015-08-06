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
st.updateValue(14, value:"simple futures")
st.updateValue(17, value:"future location")
st.updateValue(18, value:"zgomot")
st.updateValue(30, value:"bluecap")
st.updateValue(22, value:"agent xmpp")
st.count

st.minKey()
st.maxKey()

st.ceiling(20)
st.floor(16)

print("\nSort Order")
st.printSortOrder()

print("\nPost Order")
st.printPostOrder()

print("\n")
st.select(6)
st.rank(30)
st.maxHeight()

st.removeMinValue()
st.removeMaxValue()
st.printSortOrder()



