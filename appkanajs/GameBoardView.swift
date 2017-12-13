//
//  GameBoardView.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit


class GameBoardView: UIView {
    
    
    
    var sign = "Cross.png"
    
    var crossCount = 0
    var circleCount = 0
    
    private var size: Int = 3
    private var winChainSize: Int = 3
    private var counter = 0
    
    var buttons = [[TicTacButton]]()
    
    weak var delegate: GameBoardViewProtocol? = nil
    
    
    init(frame: CGRect, size: Int, winChainSize: Int) {
        let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/CGFloat(size))
        
        self.size = size
        self.winChainSize = winChainSize
        
        super.init(frame: frame)
        for i in 0..<size {
            buttons.append([TicTacButton]())
            for j in 0..<size{
                let button: TicTacButton =
                    TicTacButton(frame: CGRect(x: i * buttonWidth + 2,
                                               y: j * buttonWidth,
                                               width: buttonWidth - 4,
                                               height: buttonWidth - 4))
                
                
                button.backgroundColor = .white
                button.isUserInteractionEnabled = true
                button.setIndex(x: i, y: j)
                button.isExclusiveTouch = true
                
                button.addTarget(self, action: #selector(GameBoardView.handleTap(sender:)), for: .touchUpInside)
                
                buttons[i].append(button)
                
                
                
                self.addSubview(button)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func resetButtons(){
        for i in 0..<size {
            for j in 0..<size{
                buttons[i][j].reset()
                
            }
        }
    }
    
    
    //MARK: Actions
    @IBAction func handleTap(sender: TicTacButton){
        // change highlighted icon 
        self.delegate?.nextPlayer()
        
        
        let image = UIImage(named: sign)
        sender.setBackgroundImage(image, for: UIControlState.normal)
        sender.isUserInteractionEnabled = false
        counter += 1
        if counter == size*size {
            self.delegate?.winnerIs(winner: "TIE")
            counter = 0
        }
        if sign == "Cross.png"  && sender.playerValue == -100{
            sign = "Circle.png"
            sender.playerValue = 1
        } else if sign == "Circle.png" && sender.playerValue == -100{
            sign = "Cross.png"
            sender.playerValue = 0
        }
        NSLog("[%d,%d]", sender.x,sender.y)
        if didWin(buttonsArr: buttons, x: sender.x, y: sender.y, sign: sender.playerValue, winChainSize: winChainSize) {
            print(String(sender.playerValue) + " win")
            let winner: String!
            counter = 0
            if sender.playerValue == 1{
                winner = "X"
            } else {
                winner = "O"
            }
            self.delegate?.winnerIs(winner: winner)
        }
    }
}
