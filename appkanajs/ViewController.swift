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
    private var size: Int = 3
    private var winChainSize: Int = 3
    
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width)/1.25) // 80% of of empty screen space
    
    
    var scoreView: ScoreView!
    var gameBoardView: GameBoardView!
    var winView: WinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.getRandomColor() // random color for background
        
        //        add score view to view controller
        scoreView = ScoreView(winChainSize: String(self.winChainSize))
        scoreView.updateSingPictureBorderColors(color: self.view.backgroundColor!)
        scoreView.delegate = self
        
        self.view.addSubview(scoreView)
        
        

        //        add gameboard view to view controller
        gameBoardView = GameBoardView(frame: CGRect(x: 0, y: offset, width: Int(width), height: Int(width)), size: size, winChainSize: winChainSize)
        self.view.addSubview(gameBoardView)
        gameBoardView.delegate = self
        
        let chooseDifferentSizeButton = UIButton(frame: CGRect(x: 0, y: offset + Int(width) + 2, width: Int(width), height: 50))
        chooseDifferentSizeButton.setTitle("Choose Different Size", for: .normal)
        chooseDifferentSizeButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        chooseDifferentSizeButton.backgroundColor = UIColor.red
        chooseDifferentSizeButton.addTarget(self, action: #selector(ViewController.chooseDifferentSize), for: .touchUpInside)
        self.view.addSubview(chooseDifferentSizeButton)
        
        var chooseDifferentSizeButtonConstraints = [NSLayoutConstraint]()
        //        BOTTOM CONSTRAINT
        chooseDifferentSizeButtonConstraints.append(NSLayoutConstraint(item: chooseDifferentSizeButton,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .bottom,
                                                        multiplier: 1,
                                                        constant: 5))
        //        LEADING CONSTRAINT
        chooseDifferentSizeButtonConstraints.append(NSLayoutConstraint(item: chooseDifferentSizeButton,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .leading,
                                                        multiplier: 1,
                                                        constant: 0))
        //        TRAILING CONSTRAINT
        chooseDifferentSizeButtonConstraints.append(NSLayoutConstraint(item: chooseDifferentSizeButton,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .trailing,
                                                        multiplier: 1,
                                                        constant: 0))
        //        HEIGHT CONSTRAINT
        chooseDifferentSizeButtonConstraints.append(NSLayoutConstraint(item: chooseDifferentSizeButton,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1,
                                                        constant: 50))
        chooseDifferentSizeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(chooseDifferentSizeButtonConstraints)
        
        var gameBoardViewConstraints = [NSLayoutConstraint]()
        gameBoardViewConstraints.append(NSLayoutConstraint(item: gameBoardView,
                                                           attribute: .bottom,
                                                           relatedBy: .equal,
                                                           toItem: chooseDifferentSizeButton,
                                                           attribute: .top,
                                                           multiplier: 1,
                                                           constant: -5))
        gameBoardViewConstraints.append(NSLayoutConstraint(item: gameBoardView,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: view,
                                                           attribute: .trailing,
                                                           multiplier: 1,
                                                           constant: 0))
        gameBoardViewConstraints.append(NSLayoutConstraint(item: gameBoardView,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: view,
                                                           attribute: .leading,
                                                           multiplier: 1,
                                                           constant: 0))
        gameBoardViewConstraints.append(NSLayoutConstraint(item: gameBoardView,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1,
                                                           constant: width))
        gameBoardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(gameBoardViewConstraints)
    }
    
    
    func getRandomColor() -> UIColor{
        //                Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func setSize(size: Int){
        self.size = size
    }
    
    func setWinChainSize(size: Int){
        self.winChainSize = size
    }
    
    @IBAction func chooseDifferentSize(){
        self.removeFromParentViewController()
        let newGame = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameBoardPickerViewController") as! GameBoardPickerViewController
        
        self.present(newGame, animated: true, completion: nil)
    }
}
extension ViewController: GameBoardViewProtocol {
    
    func winnerIs(winner: String) {
        //        create win view and update score
        winView = WinView(frame: CGRect(x: 0, y: offset, width: Int(width), height: Int(width)), winner: winner)
        self.view.addSubview(winView)
        winView.delegate = self
        scoreView.update(winner: winner)
    }
    func nextPlayer() {
        scoreView.nextPlayer()
    }
}

extension ViewController: WinViewProtocol {
    //    play again function -- for play again button in WinViewController
    func playAgain() {
        gameBoardView.resetButtons()
        winView!.removeFromSuperview()
        self.view.backgroundColor = getRandomColor()
        scoreView.updateSingPictureBorderColors(color: self.view.backgroundColor!)
    }
    
}

extension ViewController: ScoreViewProtocol {
    func setupInitConstraints() {
        var scoreViewConstraints = [NSLayoutConstraint]()
        scoreView.backgroundColor = .red
        scoreViewConstraints.append(NSLayoutConstraint(item: scoreView,
                                                       attribute: .topMargin,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: .topMargin,
                                                       multiplier: 1,
                                                       constant: 0))
        scoreViewConstraints.append(NSLayoutConstraint(item: scoreView,
                                                       attribute: .leading,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: .leading,
                                                       multiplier: 1,
                                                       constant: 0))
        scoreViewConstraints.append(NSLayoutConstraint(item: scoreView,
                                                       attribute: .trailing,
                                                       relatedBy: .equal,
                                                       toItem: view,
                                                       attribute: .trailing,
                                                       multiplier: 1,
                                                       constant: 0))
        scoreViewConstraints.append(NSLayoutConstraint(item: scoreView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1,
                                                       constant: 0))
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(scoreViewConstraints)
        
    }
}










