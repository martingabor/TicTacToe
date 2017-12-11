//
//  ViewController.swift
//  appkanajs
//
//  Created by Martin Gábor on 08/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit

@IBDesignable class ViewController: UIViewController {
    
    private var customView: UIView!
    
    @IBOutlet var blurEffectView: UIVisualEffectView!
    
    @IBOutlet var circleCountLabel: UILabel!
    @IBOutlet var crossCountLabel: UILabel!
    @IBOutlet var playAgainButton: UIButton!
    @IBOutlet var winnerLabel: UILabel!
    
    var winAlert: UIAlertController!
    
    var sign:String = ""//start sign of player
    var counter:Int = 0
    
    var crossCount = 0
    var circleCount = 0
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    
    var buttonsArr: Array = Array(repeating: Array(repeating:0 , count: 3), count: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = self.getRandomColor()
        
        let offset: Int = Int((height - width)/2)
        let buttonWidth: Int = Int(width/3)
        counter = 0
        sign = "Cross.png"
        if crossCount == 0 && circleCount == 0 {
            circleCountLabel = UILabel(frame: CGRect(x: 0, y: offset - 50, width: Int(width/2), height: 60))
            circleCountLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
            circleCountLabel.textAlignment = .center
            
            crossCountLabel = UILabel(frame: CGRect(x: Int(width/2), y: offset - 50, width: Int(width/2), height: 60))
            crossCountLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
            crossCountLabel.textAlignment = .center


            self.view.addSubview(crossCountLabel)
            self.view.addSubview(circleCountLabel)
        }
        circleCountLabel.text = String(circleCount)
        circleCountLabel.adjustsFontSizeToFitWidth = true
        
        crossCountLabel.text = String(crossCount)
        crossCountLabel.adjustsFontSizeToFitWidth = true
        
       
        for i in 0..<3 {
            for j in 0..<3{
                let button: TicTacButton = TicTacButton(frame: CGRect(x: i*buttonWidth+2, y: j*buttonWidth + offset, width: buttonWidth-4, height: buttonWidth-4))
                
                //na swipe neskor na 2048 bude treba toto zatial staci tap na piskorky
                /*let swipeButtonDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.buttonDown(sender:)))
                 swipeButtonDown.direction = UISwipeGestureRecognizer.direction.down
                 button.addGestureRecognizer(swipeButtonDown)
                 
                 */
                
                button.backgroundColor = UIColor.white
                button.setTitleColor(UIColor.black, for: UIControlState.normal)
                button.isUserInteractionEnabled = true
                buttonsArr[i][j] = -100
                
                button.setIndex(x: i, y: j)
                
                button.addTarget(self, action: #selector(ViewController.handleTap(sender:)), for: .touchUpInside)
                
                
                self.view.addSubview(button)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func handleTap(sender: TicTacButton){
        
        let image = UIImage(named: sign)
        sender.setBackgroundImage(image, for: UIControlState.normal)
        sender.isUserInteractionEnabled = false
        
        if sign == "Cross.png"  && buttonsArr[sender.x][ sender.y] == -100{
            sign = "Circle.png"
            buttonsArr[sender.x][sender.y] = 1
            sender.playerValue = 1
        } else if sign == "Circle.png" && buttonsArr[sender.x][ sender.y] == -100{
            sign = "Cross.png"
            buttonsArr[sender.x][sender.y] = 0
            
            sender.playerValue = 0
        }
        counter += 1
        switch didWin(){
        case 1: print("X win"); winInfo(winner: "X"); crossCount += 1;
        case 0: print("O win"); winInfo(winner: "O"); circleCount += 1;
        default: print("TIE")
        if counter == 9 {
            
            playAgainButton.removeFromSuperview()
            blurEffectView.removeFromSuperview()
            
            viewDidLoad()
            }
        }
        
        
    }
    
    func winInfo(winner:String){
        
        let offset: Int = Int((height - width)/2)
        
        if crossCount == 10 || circleCount == 10 {
            crossCount = 0
            circleCount = 0
            crossCountLabel.removeFromSuperview()
            circleCountLabel.removeFromSuperview()
        }
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
        blurEffectView.frame = CGRect(x: 0, y: offset, width: Int(width), height: Int(width))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        
        winnerLabel = UILabel(frame:CGRect(x: 0, y: offset, width: Int(width), height: 100))
        
        winnerLabel.font = UIFont(name:"American Typewriter", size: 40)
        winnerLabel.text = winner + " won !"
        winnerLabel.textAlignment = .center
        
        self.view.addSubview(winnerLabel)
        
        //play again button /poloha rozmery/napis/font/farba pozadia/akcia ked sa stlaci / pridanie do subview
        playAgainButton = UIButton(frame: CGRect(x: 0, y: offset + 100, width: Int(width), height: 100))
        playAgainButton.setTitle("Play Again!", for: .normal)
        playAgainButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        playAgainButton.backgroundColor = getRandomColor()
        
        playAgainButton.addTarget(self,
                                  action: #selector(playAgain(_:)), for: .touchUpInside)
        self.view.addSubview(playAgainButton)
        
        

        
        
        
    }
    
    func didWin() -> Int{
        
        
        // 1 ak vyhra X
        // 0 ak vyhra O
        // -1 ak je remiza
        var row = 0
        var column = 0
        var diag1 = 0
        var diag2 = 0
        
        for i in 0..<3 {
            for j in 0..<3 {
                row += buttonsArr[i][j]
                column += buttonsArr[j][i]
                if i == j {
                    diag1 += buttonsArr[i][j]
                }
                if i + j == 2 {
                    diag2 += buttonsArr[i][j]
                }
            }
            if row == 0 || column == 0 {
                //0 win
                return 0
            } else if  row == 3 || column == 3 {
                //X win
                return 1
                
            }
            row = 0
            column = 0
        }
        if diag1 == 0 || diag2 == 0 {
            //O win
            return 0
            
        }
        if diag1 == 3 || diag2 == 3 {
            //X win
            return 1
            
        }
        return -1
    }
    
    func getRandomColor() -> UIColor{
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton){
        sender.removeFromSuperview()
        blurEffectView.removeFromSuperview()
        winnerLabel.removeFromSuperview()
        
        self.viewDidLoad()
    }
    
}

