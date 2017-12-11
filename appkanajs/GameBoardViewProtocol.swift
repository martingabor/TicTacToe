//
//  GameBoardViewProtocol.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit

protocol GameBoardViewProtocol: NSObjectProtocol {
    func winnerIs(winner: String, crossCount: Int, circleCount: Int)
}
