//
//  TwoSum.swift
//  Demo
//  https://leetcode.com/problems/two-sum/
//  Created by louisysshen(沈亦舒) on 2019/1/21.
//  Copyright © 2019 louisysshen(沈亦舒). All rights reserved.
//

import UIKit

class TwoSum: NSObject {
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int]
    {
        var dic = [Int:Int]()
        for index:Int in 0...nums.count-1
        {
            if (dic[nums[index]] != nil)
            {
                return [index, dic[nums[index]]!]
            }
            dic[target - nums[index]] = index
        }
        return [0,0]
    }
}
