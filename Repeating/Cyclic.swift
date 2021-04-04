//
//  Cyclic.swift
//  Repeating
//
//  Created by Takamiya Kengo on 2021-04-01.
//

import Foundation

func cyclic(){
  let read = Int(readLine()!)
  var arrayCount = [Int]()
  var arrSample = [[Int]]()
  let q = Queue<Int>()
  
  for _ in 1...read! {
    var num = Int(readLine()!)
    arrayCount.append(num!)
    var nums = readLine()!.split(separator: " ").map{Int($0)!}
    nums.insert(0, at: 0)
    arrSample.append(nums)
  }
  //  print(arrSample)
  //  print(arrayCount)
  
  func cycleCheck(arr:[Int],check:inout [Int],color:inout  Int,doubleCheck: inout [Bool]) {
    //    var doubleCheck = [Bool](repeating: false, count: check.count)
    while !q.isEmpty() {
      let u = q.dequeue()!
      if check[u] == 0 {
        check[u] = color
        doubleCheck[u] = true
        q.enqueue(item: arr[u])
      }
    }
    for i in 1...arr.count-1 {
      if (check[i] == 0) && (doubleCheck[i] == false) {
        color += 1
        check[i] = color
        doubleCheck[i] = true
        q.enqueue(item: arr[i])
        cycleCheck(arr:arr,check: &check,color:&color,doubleCheck: &doubleCheck)
      }
    }
  }
  
  for i in 0...read!-1 {
    var checkArr = [Int](repeating: 0, count: arrayCount[i]+1)
    var doubleCheck = [Bool](repeating: false, count: arrayCount[i]+1)
    var color = 1
    q.enqueue(item: arrSample[i][1])
    cycleCheck(arr: arrSample[i], check: &checkArr, color: &color, doubleCheck: &doubleCheck)
    print(color)
    //    print(checkArr)
  }
}


