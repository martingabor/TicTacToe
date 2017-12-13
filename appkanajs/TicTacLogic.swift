//
//  TicTacLogic.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import Foundation

func didWin(buttonsArr:[[TicTacButton]]) -> Int{
    
    // 1 ak vyhra X
    // 0 ak vyhra O
    // 2 ak sa este hra
    // -1 ak je remiza
    
    var counter = 0
    var row = 0
    var column = 0
    var diag1 = 0
    var diag2 = 0
    let size = buttonsArr.count
    
    for i in 0..<size {
        for j in 0..<size {
            if buttonsArr[i][j].playerValue != -100 {
                counter += 1
            }
            row += buttonsArr[i][j].playerValue
            column += buttonsArr[j][i].playerValue
            if i == j {
                diag1 += buttonsArr[i][j].playerValue
            }
            if i + j == size - 1 {
                diag2 += buttonsArr[i][j].playerValue
            }
        }
       
        if row == 0 || column == 0 {
            //0 win
            return 0
        } else if  row == size || column == size {
            //X win
            return 1
            
        }
        row = 0
        column = 0
    }
    if diag1 == 0 || diag2 == 0 {
        //O win
        return 0
        
    }
    if diag1 == size || diag2 == size {
        //X win
        return 1
        
    }
    // remiza
    if counter == size * size{
        return -1
    }
    return 2
    
}
