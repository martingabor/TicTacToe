//
//  button.swift
//  appkanajs
//
//  Created by Martin Gábor on 09/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit

class TicTacButton: UIButton {
    
    var x = -1
    var y = -1
    var playerValue = -100
    
    func reset(){
        self.x = -1
        self.y = -1
        self.playerValue = -100
        self.setBackgroundImage(nil, for: .normal)
        self.isUserInteractionEnabled = true
        self.backgroundColor = .white
    }

    func setIndex(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}
