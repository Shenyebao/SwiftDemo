//
//  RBTree.swift
//  Demo
//
//  Created by louisysshen(沈亦舒) on 2018/12/18.
//  Copyright © 2018 louisysshen(沈亦舒). All rights reserved.
//

import Foundation

enum RBTColor
{
    case black
    case red
}

class RBTreeNode<ElementType:Comparable>:NSObject,NSCopying
{
    var key:ElementType
    var objValue:AnyObject? = nil
    var Color:RBTColor = RBTColor.red
    var lChild:RBTreeNode? = nil
    var rChild:RBTreeNode? = nil
    var parent:RBTreeNode? = nil

    public required init(_ key:ElementType, _ objValue:AnyObject?)
    {
        self.key = key
        self.objValue = objValue
    }
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copyNode = type(of: self).init(self.key, self.objValue ?? nil)
        copyNode.Color = self.Color
        copyNode.lChild = self.lChild
        copyNode.rChild = self.rChild
        copyNode.parent = self.parent
        return copyNode
    }
}

class RBTree<ElementType:Comparable>: NSObject
{
    private var root:RBTreeNode<ElementType>? = nil
    private(set) var count:Int = 0
    private lazy var sentry:RBTreeNode<ElementType>? = RBTreeNode<ElementType>(root!.key, nil)
    
    public convenience init(withNodes data:[RBTreeNode<ElementType>])
    {
        self.init()
        for node:RBTreeNode<ElementType> in data
        {
            self.insertNode(node: node)
        }
    }
    
    public func insertNode(node:RBTreeNode<ElementType>)
    {
        let currentCount = count
        _insertNodeBasicBinary(node: node)
        if (currentCount != count)
        {
            _insertNode_case1(node: node)
        }
    }
    
    public func deleteNode(node:RBTreeNode<ElementType>)
    {
        
    }
    
    public func findNodeWithKey(key:ElementType) -> RBTreeNode<ElementType>?
    {
        var nodePointer = root
        while true {
            if (nodePointer == nil)
            {
                return nil
            }
            else if (nodePointer?.key == key)
            {
                return (nodePointer?.copy() as! RBTreeNode<ElementType>)
            }
            else if (nodePointer!.key < key)
            {
                nodePointer = nodePointer?.rChild
            }
            else
            {
                nodePointer = nodePointer?.lChild
            }
        }
    }
    
    //MARK: private function
    
    //获得给定节点的叔父节点
    private func uncleNode(node:RBTreeNode<ElementType>) -> RBTreeNode<ElementType>?
    {
        if (node.parent == nil || node.parent?.parent == nil)
        {
            return nil
        }
        let grandParent = node.parent?.parent
        if (grandParent?.lChild === node.parent)
        {
            return grandParent?.rChild
        }
        else
        {
            return grandParent?.lChild
        }
    }
    
    private func _replaceNode(node oldNode:RBTreeNode<ElementType> ,withNode newNode:RBTreeNode<ElementType>)
    {
        oldNode.objValue = newNode.objValue
    }
    
    private func _fillLeafNode(node:RBTreeNode<ElementType>)
    {
        if (node.lChild == nil)
        {
            node.lChild = sentry
        }
        if (node.rChild == nil)
        {
            node.rChild = sentry
        }
    }
    
    /// 按照基本的二叉树插入
    ///
    /// - Parameter node: 待插入节点
    private func _insertNodeBasicBinary(node:RBTreeNode<ElementType>)
    {
        count = count + 1
        if (root == nil)
        {
            root = node
            return
        }
        var nodePointer = root
        while true
        {
            if (nodePointer!.key == node.key)
            {
                count = count - 1
                _replaceNode(node: nodePointer!, withNode: node)
                return
            }
            if (nodePointer!.key < node.key)
            {
                if (nodePointer?.rChild != nil)
                {
                    nodePointer = nodePointer?.rChild
                }
                else
                {
                    node.parent = nodePointer
                    nodePointer?.rChild = node
                    break
                }
            }
            else
            {
                if (nodePointer?.lChild != nil)
                {
                    nodePointer = nodePointer?.lChild
                }
                else
                {
                    node.parent = nodePointer
                    nodePointer?.lChild = node
                    break
                }
            }
        }
    }
    
    //插入的节点恰好为根节点的情况
    private func _insertNode_case1(node:RBTreeNode<ElementType>)
    {
        if (node === root)
        {
            root?.Color = RBTColor.black
        }
        else
        {
            _insertNode_case2(node: node)
        }
    }
    
    //插入节点的父节点是黑色的情况
    private func _insertNode_case2(node:RBTreeNode<ElementType>)
    {
        if (node.parent?.Color == RBTColor.black)
        {
            //do nothing
        }
        else
        {
            _insertNode_case3(node: node)
        }
    }
    
    //插入节点的父节点为红色，且叔父节点也为红色的情况
    private func _insertNode_case3(node:RBTreeNode<ElementType>)
    {
        if (node.parent?.Color == RBTColor.red && uncleNode(node: node)?.Color == RBTColor.red)
        {
            let grandParent = node.parent!.parent!
            node.parent?.Color = RBTColor.black
            uncleNode(node: node)?.Color = RBTColor.black
            grandParent.Color = RBTColor.red
            _insertNode_case1(node: grandParent)
        }
        else
        {
            _insertNode_case4(node: node)
        }
    }
    
    //插入节点的父节点为红色，但是叔父节点为黑色或者没有的情况
    private func _insertNode_case4(node:RBTreeNode<ElementType>)
    {
        let grandParent = node.parent!.parent!
        var nodev = node
        if (node.parent?.rChild === node && grandParent.lChild === node.parent)
        {
            _rotate_left(node: node.parent!)
            nodev = nodev.lChild!
        }
        else if (node.parent?.lChild === node && grandParent.rChild === node.parent)
        {
            _rotate_right(node: node.parent!)
            nodev = nodev.rChild!
        }
        _insertNode_case5(node: nodev)
    }
    
    //祖父和父亲节点在同侧的情况
    private func _insertNode_case5(node:RBTreeNode<ElementType>)
    {
        let grandParent = node.parent!.parent!
        node.parent?.Color = RBTColor.black
        grandParent.Color = RBTColor.red
        if (node.parent?.lChild === node && grandParent.lChild === node.parent)
        {
            _rotate_right(node: grandParent)
        }
        else if (node.parent?.rChild === node && grandParent.rChild === node.parent)
        {
            _rotate_left(node: grandParent)
        }
    }
    
    //右旋（左孩子为新的父亲节点）
    private func _rotate_right(node:RBTreeNode<ElementType>)
    {
        let parent = node.parent
        if (parent?.rChild === node)
        {
            parent?.rChild = node.lChild
            node.lChild?.parent = parent
            node.lChild = parent?.rChild?.rChild
            parent?.rChild?.rChild?.parent = node
            node.parent = parent?.rChild
            parent?.rChild?.rChild = node
        }
        else if (parent?.lChild === node)
        {
            parent?.lChild = node.lChild
            node.lChild?.parent = parent
            node.lChild = parent?.lChild?.rChild
            parent?.lChild?.rChild?.parent = node
            node.parent = parent?.lChild
            parent?.lChild?.rChild = node
        }
    }
    
    //左旋（右孩子为新的父亲节点）
    private func _rotate_left(node:RBTreeNode<ElementType>)
    {
        let parent = node.parent
        if (parent?.rChild === node)
        {
            parent?.rChild = node.rChild
            node.rChild?.parent = parent
            node.rChild = parent?.rChild?.lChild
            parent?.rChild?.lChild?.parent = node
            node.parent = parent?.rChild
            parent?.rChild?.lChild = node
        }
        else if (parent?.lChild === node)
        {
            parent?.lChild = node.rChild
            node.rChild?.parent = parent
            node.rChild = parent?.lChild?.lChild
            parent?.lChild?.lChild?.parent = node
            node.parent = parent?.lChild
            parent?.lChild?.lChild = node
        }
    }
}

