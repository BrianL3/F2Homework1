// Playground - noun: a place where people can play

import UIKit

class Stack {
  var theStack = ["Russel","Marshawn","Aaron"]
  
  func push(nameToPush : String){
    theStack.append(nameToPush)
  }
  
  func pop() -> String? {
    if let popped = self.theStack.last {
      theStack.removeLast()
      return popped
    }else{
      return nil
    }
  }
  
  func peek() -> String? {
    return self.theStack.last
  }
  
}

let myStack = Stack()

myStack.peek()

myStack.push("Brad")

myStack.pop()

myStack.peek()

