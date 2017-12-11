//
//  ViewController.swift
//  appkanajs
//
//  Created by Martin Gábor on 08/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit


@IBDesignable class ViewController: UIViewController {
    
    @IBOutlet var contentView: UIView!
    
    
    
    
    var sign:String = ""//start sign of player
    var counter:Int = 0
    
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width)/1.25)
    let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/3)
    
    
    var buttonsArr: Array = Array(repeating: Array(repeating:0 , count: 3), count: 3)
    
    var scoreView: ScoreView = ScoreView()
    var gameBoardView: GameBoardView = GameBoardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.getRandomColor()
        
        sign = "Cross.png"
        
        
        scoreView = ScoreView(frame: CGRect(x: 0, y: 20, width: Int(width), height: offset))
        self.view.addSubview(scoreView)
        
        gameBoardView = GameBoardView(frame: CGRect(x: 0, y: offset, width: Int(width), height: Int(width)))
        self.view.addSubview(gameBoardView)
        gameBoardView.delegate = self
        
    }
    
    func nextGame(){
        gameBoardView.resetButtons()
        
    }
    
    
    func getRandomColor() -> UIColor{
        //        Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}
extension ViewController: GameBoardViewProtocol {
    func winnerIs(winner: String, crossCount: Int, circleCount: Int) {
        let winView = WinView(frame: CGRect(x: 0, y: offset, width: Int(width), height: Int(width)), winner: winner)
        self.view.addSubview(winView)
        winView.delegate = self
        scoreView.change(crossCount: crossCount, circleCount: circleCount)
    }
}

extension ViewController: WinViewProtocol {
    func playAgain() {
        nextGame()
    }
}






