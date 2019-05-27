//
//  ViewController.swift
//  Demo
//
//  Created by louisysshen(沈亦舒) on 2018/12/18.
//  Copyright © 2018 louisysshen(沈亦舒). All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //RBTree
//        let map = RBTMap<Float>(withValuesAndKeys: [(2,NSString(string: "two"))])
//        map.setObject(object: NSString(string: "two"), forKey: 2)
//        map.setObject(object: NSString(string: "one"), forKey: 1)
//        map.setObject(object: NSString(string: "three"), forKey: 3)
//        map.setObject(object: NSString(string: "two point five"), forKey: 2.5)
//        map.setObject(object: NSString(string: "two point three"), forKey: 2.3)
//
//        let value:NSString = map.objectForKey(key: 2.3) as! NSString
//        print(value)
        
        //Quick Sort
        let a = [3,2,4]
        TwoSum.twoSum(a, 6)
    }


}

