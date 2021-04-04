//
//  repeating.swift
//  Repeating
//
//  Created by Takamiya Kengo on 2021-03-29.
//

import Foundation

func repeatingCheck() {
  
  let read = readLine()!.split(separator: " ").map{Int($0)!}
  
  var firstNum = read[0]
  var powNum = read[1]
  var repeatArray = [Int]()
  repeatArray.append(firstNum)
  let q = Queue<Int>()
  
  q.enqueue(item: firstNum)
  //  print("powNum is \(powNum)")
  
  while !q.isEmpty() {
    let u = q.dequeue()!
    //    print("u is \(u)")
    
    var sum = 0
    var arr = Array(String(u))
    
//    print("arr is \(arr)")
    
    for i in 0...arr.count-1 {
      //      sum = sum + Int(pow(Double(i),Double(powNum)))
      let newI = String(arr[i])
      sum = sum + Int(pow(Double(newI)!,Double(powNum)))
      //      print("i is \(i)")
    }
    
    if repeatArray.contains(sum) {
      var index = repeatArray.index(of: sum)
      print(index!)
      break
    } else {
      //      print("sum is \(sum)")
      repeatArray.append(sum)
      q.enqueue(item: sum)
      //      print("repeatArray is \(repeatArray)")
    }
  }
}
