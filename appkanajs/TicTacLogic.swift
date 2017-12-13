//
//  TicTacLogic.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import Foundation

func didWin(buttonsArr: [[TicTacButton]],x: Int, y: Int, sign: Int, winChainSize: Int) -> Bool{
    print("START.")
    NSLog("For Button [%d,%d] with sign %d",x , y, sign)
    let col = 1 +
        findWinner(buttonsArr: buttonsArr, x: x, y: y - 1, offset_x: 0, offset_y: -1, sign: sign) +
        findWinner(buttonsArr: buttonsArr, x: x, y: y + 1, offset_x: 0, offset_y: 1, sign: sign)
    NSLog("Col =  %d", col)
    let row = 1 +
        findWinner(buttonsArr: buttonsArr, x: x - 1, y: y, offset_x: -1, offset_y: 0, sign: sign) +
        findWinner(buttonsArr: buttonsArr, x: x + 1, y: y, offset_x: 1, offset_y: 0, sign: sign)
    NSLog("Row =  %d", row)
    let diag1 = 1 +
        findWinner(buttonsArr: buttonsArr, x: x - 1, y: y - 1, offset_x: -1, offset_y: -1, sign: sign) +
        findWinner(buttonsArr: buttonsArr, x: x + 1, y: y + 1, offset_x: 1, offset_y: 1, sign: sign)
    NSLog("Diag1 = %d", diag1)
    
    let diag2 = 1 +
        findWinner(buttonsArr: buttonsArr, x: x - 1, y: y + 1, offset_x: -1, offset_y: 1, sign: sign) +
        findWinner(buttonsArr: buttonsArr, x: x + 1, y: y - 1, offset_x: 1, offset_y: -1, sign: sign)
    NSLog("Diag2 = %d\nEND.", diag2)
    if row >= winChainSize || col >= winChainSize || diag1 >= winChainSize || diag2 >= winChainSize {
        return true
    }
    return false
}

func findWinner(buttonsArr: [[TicTacButton]], x: Int, y: Int, offset_x: Int, offset_y: Int, sign: Int) -> Int {
    let size = Int(buttonsArr.count)
    if (x < size && x >= 0) && (y < size && y >= 0) && buttonsArr[x][y].playerValue == sign {
        return 1 + findWinner(buttonsArr: buttonsArr, x: x + offset_x, y: y + offset_y, offset_x: offset_x, offset_y: offset_y, sign: sign)
    }
    return 0
}
