//
//  ScoreView.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//
import UIKit


class ScoreView: UIView {
    
    @IBOutlet var circleCountLabel: UILabel!
    @IBOutlet var crossCountLabel: UILabel!
    @IBOutlet var winChainSizeLabel: UILabel!
    
    @IBOutlet var crossCounterPictureView: TicTacImageView!
    @IBOutlet var circleCounterPictureView: TicTacImageView!
    
    let width = UIScreen.main.bounds.size.width
    let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width) * 0.8)//80% of screen size
    let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/3)
    
    weak var delegate: WinViewProtocol? = nil
    weak var delegate2: GameBoardViewProtocol? = nil
    
    
    init(frame: CGRect, winChainSize: String) {
        super.init(frame: frame)
        
        
        //        add white background to whiteCoverView
        //        this is our bottom layer of Score Board View
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: Int(width), height: buttonWidth + 45))
        whiteCoverView.backgroundColor = UIColor.white
        self.addSubview(whiteCoverView)
        
        
        //        add image subview to the left/right side of scoreboard (whiteCoverView)
        //        cross image first
        let crossCounterPicture = UIImage(named: "Cross.png")// normal state
        crossCounterPictureView = TicTacImageView(frame: CGRect(x: 2, y: 25, width: buttonWidth - 4, height: buttonWidth - 4))
        crossCounterPictureView.image = crossCounterPicture
        
        whiteCoverView.addSubview(crossCounterPictureView)
        
        //        then circle image
        let circleCounterPicture = UIImage(named: "Circle.png") // normal sate
        
        circleCounterPictureView = TicTacImageView(frame: CGRect(x: 2 * buttonWidth + 2, y: 25, width: buttonWidth - 4, height: buttonWidth - 4))
        circleCounterPictureView.image = circleCounterPicture
        
        whiteCoverView.addSubview(circleCounterPictureView)
        
        crossCounterPictureView.isHighlighted = true
        crossCounterPictureView.layer.borderWidth = 3
        
        
        //        counter labels initial setup
        //        cross first
        crossCountLabel = UILabel(frame: CGRect(x: 2, y: offset - 70, width: buttonWidth - 4, height: 40))
        crossCountLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        crossCountLabel.textAlignment = .center
        //        then circle
        circleCountLabel = UILabel(frame: CGRect(x:  2 * buttonWidth + 2, y: offset - 70, width: buttonWidth - 4, height: 40))
        circleCountLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        circleCountLabel.textAlignment = .center
        //        initial setup for cross and circle count labels
        crossCountLabel.text = "0"
        circleCountLabel.text = "0"
        //        add both to the screen
        self.addSubview(crossCountLabel)
        self.addSubview(circleCountLabel)
        
        winChainSizeLabel = UILabel(frame: CGRect(x: buttonWidth + 2, y: offset - 70, width: buttonWidth - 4, height: 40))
        winChainSizeLabel.text = "Win Chain Size: " + winChainSize
        winChainSizeLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        winChainSizeLabel.lineBreakMode = .byWordWrapping
        winChainSizeLabel.numberOfLines = 0
        self.addSubview(winChainSizeLabel)
        
        let resetButton = UIButton(frame: CGRect(x: buttonWidth + 2, y: 55, width: buttonWidth - 4, height: buttonWidth - 54))
        resetButton.addTarget(self, action: #selector(ScoreView.resetCounters(sender:)), for: .touchUpInside)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        resetButton.setTitleColor(UIColor.black, for: .normal)
        resetButton.layer.borderWidth = 4
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.cornerRadius = 25
        resetButton.isUserInteractionEnabled = true
        self.addSubview(resetButton)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func update(winner: String) {
        if winner == "X" {
            self.crossCountLabel.text = String(Int(self.crossCountLabel.text!)! + 1)
        } else if winner == "O" {
            self.circleCountLabel.text = String(Int(self.circleCountLabel.text!)! + 1)
        }
    }
    
    func nextPlayer(){
        
        if crossCounterPictureView.isHighlighted {
            crossCounterPictureView.isHighlighted = false
            circleCounterPictureView.isHighlighted = true
            
            crossCounterPictureView.isWaiting()
            circleCounterPictureView.onMove()
            
            
        } else if circleCounterPictureView.isHighlighted {
            circleCounterPictureView.isHighlighted = false
            crossCounterPictureView.isHighlighted = true
            
            crossCounterPictureView.onMove()
            circleCounterPictureView.isWaiting()

        }
    }
    
    func updateSingPictureBorderColors(color: UIColor){
        crossCounterPictureView.layer.borderColor = color.cgColor
        circleCounterPictureView.layer.borderColor = color.cgColor
    }
    
    @IBAction func resetCounters(sender: UIButton){
        self.delegate?.playAgain()
        
        crossCountLabel.text = "0"
        circleCountLabel.text = "0"
        
    }
    
}



