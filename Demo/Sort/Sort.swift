//
//  Sort.swift
//  Demo
//
//  Created by louisysshen(沈亦舒) on 2019/1/18.
//  Copyright © 2019 louisysshen(沈亦舒). All rights reserved.
//

import UIKit

class Sort: NSObject
{
    //MARK: QuickSort
    public static func quickSort<T:Comparable>(_ array:inout [T])
    {
        _quicksort(&array, 0, array.count - 1)
    }
    
    private static func _quicksort<T:Comparable>(_ array:inout [T], _ begin:Int, _ end:Int)
    {
        if (begin >= end)
        {
            return
        }
        let p = _quicksort_partition(&array, begin, end)
        _quicksort(&array, begin, p - 1)
        _quicksort(&array, p + 1, end)
    }
    
    private static func _quicksort_partition<T:Comparable>(_ array:inout [T], _ begin:Int, _ end:Int) -> Int
    {
        let pivot = end
        var i = begin - 1
        var j = begin
        while j < array.count
        {
            if (array[j] < array[pivot])
            {
                i = i + 1
                _arraySwap(&array, i, j)
            }
            j = j + 1
        }
        _arraySwap(&array, i + 1, pivot)
        return (i + 1)
    }
    
    //MARK: help function
    private static func _arraySwap<T:Comparable>(_ array: inout [T], _ firstIndex:Int, _ secondIndex:Int)
    {
        let temp = array[secondIndex]
        array[secondIndex] = array[firstIndex]
        array[firstIndex] = temp
    }
}
