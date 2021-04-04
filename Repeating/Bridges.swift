//
//  Bridges.swift
//  Repeating
//
//  Created by Takamiya Kengo on 2021-04-03.
//

import Foundation

func bridge() {
  struct Square {
    let x: Int
    let y: Int
  }
  
  let dx = [0, 0, 1, -1]
  let dy = [1, -1, 0, 0]
  let read = Int(readLine()!)
  let q = Queue<(Int,Int)>()
  var bridgeArr = [Int]()
  var checkBox = [[Bool]](repeating: [Bool](repeating: false, count: read!), count: read!)
  var townMap = [[Int]]()
  var colorMap = [[Int]](repeating: [Int](repeating: 0, count: read!), count: read!)
  
  for _ in 0...read!-1 {
    let row = readLine()!.split(separator: " ").map{Int($0)!}
    townMap.append(row)
  }
  
  func bfs(square: Square, id: Int) {
    let q = Queue<Square>()
    q.enqueue(item: square)
    colorMap[square.x][square.y] = id
    
    while !q.isEmpty() {
      let sq = q.dequeue()!
      let x = sq.x
      let y = sq.y
      for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        if nx >= 0 && nx < read! && ny >= 0 && ny < read! {
          if (townMap[nx][ny] == 1 && colorMap[nx][ny] == 0) { // check if there's a house
            q.enqueue(item: Square(x: nx, y: ny))
            colorMap[nx][ny] = id
          }
        }
      }
    }
  }
  
  var id = 0
  for x in 0..<read! {
    for y in 0..<read! {
      if townMap[x][y] == 1 && colorMap[x][y] == 0 {
        id += 1
        bfs(square: Square(x: x, y: y), id: id)
      }
    }
  }
  
  func getPlace(num : Int,colorMap : inout [[Int]]) {
    for i in 0...read!-1 {
      for j in 0...read!-1 {
        if colorMap[i][j] == num {
          q.enqueue(item: (i,j))
        }
      }
    }
  }
  
  func makeBridge(num : Int,colorMap : inout [[Int]],checkBox:inout [[Bool]]) {
    while !q.isEmpty() {
      let u = q.dequeue()
      if checkBox[u!.1][u!.0] == false {
        for n in 0..<4 {
          let newX = u!.1 + dx[n]
          let newY = u!.0 + dy[n]
          if newX >= 0 && newX < read! && newY >= 0 && newY < read! {
            if colorMap[newY][newX] == 0 {
              colorMap[newY][newX] = num
              checkBox[u!.0][u!.1] = true
            }
          }
        }
      }
    }
  }
  
  func check(num : Int,colorMap :[[Int]]) -> Bool {
    for i in 0...read!-1 {
      for j in 0...read!-1 {
        if colorMap[i][j] == num{
          for n in 0..<4 {
            let newX = j + dx[n]
            let newY = i + dy[n]
            if newX >= 0 && newX < read! && newY >= 0 && newY < read! {
              if !(colorMap[newY][newX] == num) && !(colorMap[newY][newX] == 0) {
                return true
              }
            }
          }
        }
      }
    }
    return false
  }
  
  for i in 1...id {
    var count = 0
    var changeOKcolorMap = colorMap
    var changeOKcheckBox = [[Bool]](repeating: [Bool](repeating: false, count: read!), count: read!)
    while !check(num: i,colorMap: changeOKcolorMap) {
      getPlace(num: i,colorMap: &changeOKcolorMap)
      makeBridge(num: i,colorMap: &changeOKcolorMap,checkBox: &changeOKcheckBox)
      count += 1
    }
    bridgeArr.append(count)
    //    print("ID is \(i)")
    //    for row in changeOKcolorMap {
    //      print(row)
    //    }
  }
  print(bridgeArr.min()!)
  //
  //  print(bridgeArr)
  //  print("")
  //  for row in townMap {
  //    print(row)
  //  }
  //  print("")
  //  for row in colorMap {
  //    print(row)
  //  }
}
