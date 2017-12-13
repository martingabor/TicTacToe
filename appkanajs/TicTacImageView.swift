//
//  TicTacImageView.swift
//  appkanajs
//
//  Created by Martin Gábor on 13/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit

class TicTacImageView: UIImageView {
    
    
    func onMove(){
        self.layer.borderWidth = 3
    }
    
    func isWaiting(){
        self.layer.borderWidth = 0
    }
}
