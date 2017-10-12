//: Playground - noun: a place where people can play

import UIKit

//-- searching a binary tree


//1
//             10
//            /  \
//           5   14
//          /    / \
//         1    11  20
//

class Node {
    
    let value: Int
    let leftChild: Node?
    let rightChild: Node?
    
    init(value: Int, leftChild: Node?, rightChild: Node?) {
        
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild

    }
    
}


//left node
let oneNode = Node(value: 1, leftChild: nil, rightChild: nil)
let fiveNode = Node(value: 5, leftChild: oneNode , rightChild: nil)
//rightNode
let twentyNode = Node(value: 20, leftChild: nil, rightChild: nil)
let elevanNode = Node(value: 11, leftChild: nil, rightChild: nil)
let fourteenNode = Node(value: 14, leftChild: elevanNode, rightChild: twentyNode)
//rootNode
let rootNode = Node(value: 10, leftChild: fiveNode, rightChild: fourteenNode)


func search(node: Node?, searchValue: Int) -> Bool {

    //recursion calling the same method your  already in with maybe different parameters
    //base case to stop infinate loop
    
    if node == nil {
        return false
    }
    
    if node?.value == searchValue {
        
        return true
        
    } else if searchValue < node!.value {
        
       return search(node: node?.leftChild, searchValue: searchValue)
        
    } else {
        
        return search(node: node?.rightChild, searchValue: searchValue)
        
    }

}

func anotherSearch(node: Node?, searchValue: Int) -> Bool {
    
    if node?.value == nil {
        
        return false
        
    } else if searchValue < node!.value {
        
        return search(node: node?.leftChild, searchValue: searchValue)
        
    } else {
        
        return search(node: node?.rightChild, searchValue: searchValue)
        
    }
    
    
}

search(node: rootNode, searchValue: 20)



















