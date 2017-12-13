//
//  GameBoardView.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit


class WinView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var circleCountLabel: UILabel!
    @IBOutlet var crossCountLabel: UILabel!
    
    
    var winAlert: UIAlertController!
    
    var sign:String = ""//start sign of player
    var counter:Int = 0
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width)/1.25)
    let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/3)
    
    
    var buttonsArr: Array = Array(repeating: Array(repeating:0 , count: 3), count: 3)
    
    weak var delegate: WinViewProtocol? = nil

    init(frame: CGRect, winner: String) {
        super.init(frame:frame)

        
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: Int(width), height: Int(width)))
        self.addSubview(contentView)
        
        let  blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
        blurEffectView.frame = CGRect(x: 0, y: 0, width: Int(width), height: Int(width))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(blurEffectView)
        
        let winnerLabel = UILabel(frame:CGRect(x: 0, y: 0, width: Int(width), height: 100))
        
        winnerLabel.font = UIFont(name:"American Typewriter", size: 40)
        winnerLabel.text = winner + " won !" 
        if winner == "TIE" {
            winnerLabel.text = winner
        }
        winnerLabel.textAlignment = .center
        
        contentView.addSubview(winnerLabel)
        
        //play again button /poloha rozmery/napis/font/farba pozadia/akcia ked sa stlaci / pridanie do subview
        let playAgainButton = UIButton(frame: CGRect(x: 0, y: 100, width: Int(width), height: 100))
        playAgainButton.setTitle("Play Again!", for: .normal)
        playAgainButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        playAgainButton.backgroundColor = ViewController().getRandomColor()
        
        playAgainButton.addTarget(self,
                                  action: #selector(playAgain(_:)), for: .touchUpInside)
        contentView.addSubview(playAgainButton)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: Actions
    
    @IBAction func playAgain(_ sender: UIButton){
        self.delegate?.playAgain()
    }
    

    
}


