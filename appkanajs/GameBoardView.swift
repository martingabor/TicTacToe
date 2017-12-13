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
    
    var size = 3
    
    
    var buttons = [[TicTacButton]]()
    
    weak var delegate: GameBoardViewProtocol? = nil
    
    
    init(frame: CGRect, size: Int) {
        let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/CGFloat(size))
        
        self.size = size
        
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
        
        if sign == "Cross.png"  && sender.playerValue == -100{
            sign = "Circle.png"
            sender.playerValue = 1
        } else if sign == "Circle.png" && sender.playerValue == -100{
            sign = "Cross.png"
            sender.playerValue = 0
        }
        
        if didWin(buttonsArr: buttons, x: sender.x, y: sender.y, sign: sender.playerValue) {
            print(String(sender.playerValue) + "win")
            let winner: String!
            if sender.playerValue == 1{
                winner = "X"
            } else {
                winner = "O"
            }
            self.delegate?.winnerIs(winner: winner)
        }
    }
    
    /*   switch didWin(buttonsArr: buttons, x: sender.x, y: sender.y, sign: sender.playerValue){
     case 1: do {
     print("X win")
     crossCount += 1
     if crossCount == 10 {
     crossCount = 0
     circleCount = 0
     }
     self.delegate?.winnerIs(winner:"X")}
     case 0: do {
     print("O win");
     circleCount += 1
     if circleCount == 10 {
     crossCount = 0
     circleCount = 0
     }
     self.delegate?.winnerIs(winner:"O")}
     case -1 : print("TIE");
     self.delegate?.winnerIs(winner: "TIE");
     default: print("este sa hra")
     
     }*/
    
    
}
