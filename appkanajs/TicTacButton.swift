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
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setIndex(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}
