//
//  Tomato.swift
//  Repeating
//
//  Created by Takamiya Kengo on 2021-04-02.
//

import Foundation

func tomato() {
  
  var count = 0
  let dx = [0, 0, 1, -1]
  let dy = [1, -1, 0, 0]
  
  var read = readLine()!.split(separator: " ").map{ Int($0)!}
  var tomatoBox = [[Int]]()
  let q = Queue<((Int,Int))>()
  
  var checkBox = [[Bool]](repeating: [Bool](repeating: false, count: read[0]), count: read[1])
  //  print(checkBox)
  for _ in 0..<read[1] {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    tomatoBox.append(row)
  }
  
//  for row in tomatoBox {
//    print(row)
//  }
  
  func check() -> Bool {
    for i in 0...read[1]-1 {
      for j in 0...read[0]-1 {
        if tomatoBox[i][j] == 1 {
          for n in 0..<4 {
            let newX = j + dx[n]
            let newY = i + dy[n]
            if newX >= 0 && newX < read[0] && newY >= 0 && newY < read[1] {
              if tomatoBox[newY][newX] == 0 {
                return false
              }
            }
          }
        }
      }
    }
    return true
  }
  
  func checkLast() -> Bool {
    for i in 0...read[1]-1 {
      for j in 0...read[0]-1 {
        if tomatoBox[i][j] == 0  {
          return true
        }
      }
    }
    return false
  }
  
  func ripe() {
    while !q.isEmpty() {
      let u = q.dequeue()
      if checkBox[u!.0][u!.1] == false {
        for n in 0..<4 {
          let newX = u!.1 + dx[n]
          let newY = u!.0 + dy[n]
          if newX >= 0 && newX < read[0] && newY >= 0 && newY < read[1] {
            if tomatoBox[newY][newX] == 0 {
              tomatoBox[newY][newX] = 1
              checkBox[u!.0][u!.1] = true
            }
          }
        }
      }
    }
  }
  
  func getPlace() {
    for i in 0...read[1]-1 {
      for j in 0...read[0]-1 {
        if tomatoBox[i][j] == 1 {
          q.enqueue(item: (i,j))
        }
      }
    }
  }
  
  while !check() {
    getPlace()
    ripe()
//    print("count is \(count)")
//    for row in tomatoBox {
//      print(row)
//    }
    count += 1
  }
  
  if !checkLast() {
  print(count)
  } else {
    print(-1)
  }
}

