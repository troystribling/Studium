//
//  Sort.swift
//  Studium
//
//  Created by Troy Stribling on 6/21/15.
//  Copyright (c) 2014 Troy Stribling. The MIT License (MIT).
//

import Foundation

public struct Sort {
    
    // implementation of selection sort
    public struct Selection {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            var minVal : Int
            for i in (0..<vals.count) {
                minVal = i
                for j in (i..<vals.count) {
                    if vals[minVal] > vals[j] {
                        minVal = j
                    }
                }
                ArrayTools.swap(&vals, index:i, withIndex:minVal)
            }
        }
        
    }
    
    // implementaion of insertion sort
    public struct Insertion {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            for i in (1..<vals.count) {
                for j in (1...i).reverse() {
                    if vals[j] < vals[j-1] {
                        ArrayTools.swap(&vals, index:j, withIndex:j-1)
                    } else {
                        break
                    }
                }
            }
        }
        
    }
    
    // implementation of shell sort
    public struct Shell {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            let n = vals.count
            var h = 1;
            while h < n/3 {
                h = 3*h+1
            }
            while h > 0 {
                self.hsort(&vals, h:h)
                h = h/3
            }
        }

        public static func hsort<T:Comparable>(inout vals:[T], h:Int) {
            for i in (h..<vals.count) {
                for var j = i; j >= h; j -= h {
                    if vals[j] < vals[j-h] {
                        ArrayTools.swap(&vals, index:j, withIndex:j-h)
                    } else {
                        break
                    }
                }
            }
        }
        
    }
    
    // implementaion of merge sort algorithms
    public struct Merge {

        // merge 2 sorted portions of array  vals[lo...mid] and vals[mid+1...hi]
        public static func merge<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, mid:Int, hi:Int) {
            var i = lo, j = mid + 1
            for k in (lo...hi) {
                tmp[k] = vals[k]
            }
            for k in (lo...hi) {
                // lower array exhausted
                if i > mid {
                    vals[k] = tmp[j++]
                // upper array exhausted
                } else if j > hi {
                    vals[k] = tmp[i++]
                // upper array larger
                } else if tmp[j] > tmp[i] {
                    vals[k] = tmp[i++]
                // lower array larger
                } else {
                    vals[k] = tmp[j++]
                }
            }
        }

        // recursive topdown merge sort implementaion
        public struct TopDown {
            
            public static func sort<T:Comparable>(inout vals:[T]) {
                var tmp = vals
                self.sort(&vals, tmp:&tmp, lo:0, hi:vals.count-1)
            }
            
            public static func sort<T:Comparable>(inout vals:[T], inout tmp:[T], lo:Int, hi:Int) {
                guard hi > lo else {
                    return
                }
                let mid = lo + (hi - lo)/2
                self.sort(&vals, tmp: &tmp, lo:lo, hi:mid)
                self.sort(&vals, tmp: &tmp, lo:mid+1, hi:hi)
                Merge.merge(&vals, tmp:&tmp, lo:lo, mid:mid, hi:hi)
            }
        }
        
        // bottom up merge sort implementation
        public struct BottomUp {
            
            public static func sort<T:Comparable>(inout vals:[T]) {
                let n = vals.count
                var tmp = vals
                // loop through subarrays with size s
                for var s = 1; s < n; s = 2*s {
                    // loop through 2 ajacent subarrays using index lo
                    for var lo = 0; lo < n-s; lo += 2*s {
                        Merge.merge(&vals, tmp:&tmp, lo:lo, mid:lo+s-1, hi:[lo+2*s-1, n-1].minElement()!)
                    }
                }
            }
        }
        
    }
    
    // implementaion of quick sort
    public struct Quick {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            ArrayTools.shuffle(&vals)
            self.sort(&vals, lo:0, hi:vals.count-1)
        }
        
        public static func sort<T:Comparable>(inout vals:[T], lo:Int, hi:Int) {
            guard hi > lo else {
                return
            }
            let j = self.partition(&vals, lo:lo, hi:hi)
            self.sort(&vals, lo:lo, hi:j-1)
            self.sort(&vals, lo:j+1, hi:hi)
        }
        
        // inplace partial sort for vals[lo...j-1] < vals[j] < vals[j+1...hi]
        public static func partition<T:Comparable>(inout vals:[T], lo:Int, hi:Int) -> Int {
            var i = lo, j = hi+1
            let pivot = vals[lo]
            while(true) {
                // find i where vals[i] are partitioned
                while vals[++i] < pivot {
                    if i == hi {
                        break
                    }
                }
                // find j vals[j] are partitioned
                while vals[--j] > pivot {
                    if j == lo {
                        break
                    }
                }
                // traversed array
                if i >= j {
                    break
                } else {
                    ArrayTools.swap(&vals, index:i, withIndex:j)
                }
            }
            // put pivot at lo in its sorted position
            ArrayTools.swap(&vals, index:lo, withIndex:j)
            return j
        }
    }
    
    // implementaion of quick sort with 3 way partitioning
    public struct Quick3way {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            self.sort(&vals, lo:0, hi:vals.count-1)
        }
        
        // inplace partial sort vals[lo...lt-1] < vals[lt...gt] < vals[gt+1...hi]
        public static func sort<T:Comparable>(inout vals:[T], lo:Int, hi:Int) {
            guard hi > lo else {
                return
            }
            var lt = lo, i = lo+1, gt = hi
            let pivot = vals[lo]
            while i <= gt {
                if vals[i] < pivot {
                    ArrayTools.swap(&vals, index:lt++, withIndex:i++)
                } else if vals[i] > pivot {
                    ArrayTools.swap(&vals, index:i, withIndex:gt--)
                } else {
                    i++
                }
            }
            self.sort(&vals, lo:lo, hi:lt-1)
            self.sort(&vals, lo:gt+1, hi:hi)
        }
    }
    
    // implementaion of heap sort
    // binary heap array storage
    // k = paranet node id
    // 2*k = left child node id
    // 2*k+1 = right child node id
    // j = child node id
    // j/2 = parent node id
    // heap sorted is defined by
    // vals[k] >= vals[2*k] && vals[k] >= vals[2*k+1]
    // vals[0] is largest value
    public struct Heap {
        
        public static func sort<T:Comparable>(inout vals:[T]) {
            var n = vals.count
            // put array in heap order largest value will be root
            //
            for k in (1...n/2).reverse() {
                self.sink(&vals, k:k, n:n)
            }
            while n > 1 {
                // sort array by by moving root to to sorted position
                ArrayTools.swap(&vals, index:0, withIndex:n-1)
                --n
                // put remainder of array in heap order once again
                self.sink(&vals, k:1, n:n)
            }
        }
        
        // lower node in tress untill heap ordered
        public static func sink<T:Comparable>(inout vals:[T], var k:Int, n:Int) {
            // k=parent node, j = child node
            while 2*k <= n {
                // left child node
                var j = 2*k
                // convert to node ids to array index
                var ji = j-1, ki = k-1
                // compare to largest child if two are present. if j > n there is only one child
                if (j < n) && vals[ji] < vals[ji+1] {
                    j++; ji++
                }
                if vals[ki] < vals[ji] {
                    // parent is less than child sink lower
                    ArrayTools.swap(&vals, index:ki, withIndex:ji)
                    k=j
                } else {
                    // parent is >= child heap order obtained
                    break
                }
            }
        }
        
    }
    
}