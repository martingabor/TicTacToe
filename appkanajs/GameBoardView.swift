//
//  GameBoardView.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit


class GameBoardView: UIView {
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width)/1.25)
    let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/3)
    
    var sign = "Cross.png"
    var counter = 0
    
    var crossCount = 0
    var circleCount = 0
    
    
    
    var buttonsArr: Array = Array(repeating: Array(repeating: 0 , count: 3), count: 3)
    var buttons = [[TicTacButton]]()
    
    weak var delegate: GameBoardViewProtocol? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        for i in 0..<3 {
            buttons.append([TicTacButton]())
            for j in 0..<3{
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
    
    
    //MARK: Actions
    @IBAction func handleTap(sender: TicTacButton){
        
        let image = UIImage(named: sign)
        sender.setBackgroundImage(image, for: UIControlState.normal)
        sender.isUserInteractionEnabled = false
        
        if sign == "Cross.png"  && sender.playerValue == -100{
            sign = "Circle.png"
//            buttonsArr[sender.x][sender.y] = 1
            sender.playerValue = 1
        } else if sign == "Circle.png" && sender.playerValue == -100{
            sign = "Cross.png"
//            buttonsArr[sender.x][sender.y] = 0
            sender.playerValue = 0
        }
        counter += 1
        switch didWin(buttonsArr: buttons){
        case 1: do {
            print("X win")
            crossCount += 1
            if crossCount == 10 {
                crossCount = 0
                circleCount = 0
            }
            self.delegate?.winnerIs(winner:"X", crossCount: crossCount, circleCount: circleCount)}
        case 0: do {
            print("O win");
            circleCount += 1
            if circleCount == 10 {
                crossCount = 0
                circleCount = 0
            }
            self.delegate?.winnerIs(winner:"O",crossCount: crossCount, circleCount: circleCount)}
        case -1 : print("TIE");
        self.delegate?.winnerIs(winner: "TIE",crossCount: crossCount, circleCount: circleCount);
        default: print("este sa hra")
      
        }
    }
    
    func resetButtons(){
        for i in 0..<3 {
            for j in 0..<3{
                buttons[i][j].reset()

            }
        }
    }
    
}
