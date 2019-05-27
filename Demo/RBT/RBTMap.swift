//
//  RBTMap.swift
//  Demo
//
//  Created by louisysshen(沈亦舒) on 2018/12/19.
//  Copyright © 2018 louisysshen(沈亦舒). All rights reserved.
//

import Foundation

class RBTMap<ElementType:Comparable>: NSObject
{
    private var tree:RBTree<ElementType>? = nil
    
    public override init()
    {
        tree = RBTree<ElementType>()
        super.init()
    }
    
    public convenience init(withValuesAndKeys valuesAndKeys:Array<(ElementType, AnyObject)>)
    {
        self.init()
        for pair:(ElementType, AnyObject) in valuesAndKeys
        {
            setObject(object: pair.1, forKey: pair.0)
        }
    }
    
    public func count() -> Int
    {
        return tree?.count ?? 0
    }
    
    public func setObject(object:AnyObject, forKey key:ElementType)
    {
        let newNode = RBTreeNode(key, object)
        tree?.insertNode(node: newNode)
    }
    
    public func objectForKey(key:ElementType) -> AnyObject?
    {
        let node = tree?.findNodeWithKey(key: key)
        return node?.objValue
    }
}
