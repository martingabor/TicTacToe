//
//  GameBoardPickerViewController.swift
//  appkanajs
//
//  Created by Martin Gábor on 13/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height
let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width) * 0.8)//80% of empty screen space


class GameBoardPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    private var gameBoardSizePickerView: UIPickerView = UIPickerView()
    private var pickBoardSizeLabel: UILabel = UILabel()
    private var pickWinChainSizeLabel: UILabel = UILabel()
    private var pickButton: UIButton = UIButton()
    
    private var pickerData: [Int] = [3,4,5,6,7,8]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickBoardSizeLabel.text = "GAMEBOARD SIZE"
        pickBoardSizeLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
        pickBoardSizeLabel.adjustsFontSizeToFitWidth = true
        
        pickBoardSizeLabel.lineBreakMode = .byWordWrapping
        pickBoardSizeLabel.numberOfLines = 0
        pickBoardSizeLabel.textAlignment = .center
        self.view.addSubview(pickBoardSizeLabel)
        
        pickWinChainSizeLabel.text = "WINCHAIN SIZE"
        pickWinChainSizeLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
        pickWinChainSizeLabel.adjustsFontSizeToFitWidth = true
        pickWinChainSizeLabel.lineBreakMode = .byWordWrapping
        pickWinChainSizeLabel.numberOfLines = 0
        pickWinChainSizeLabel.textAlignment = .center
        self.view.addSubview(pickWinChainSizeLabel)
        
        pickButton.setTitle("Confirm choice", for: .normal)
        pickButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        pickButton.backgroundColor = UIColor.red
        pickButton.addTarget(self, action: #selector(GameBoardPickerViewController.sizePicked(sender:)), for: .touchUpInside)
        self.view.addSubview(pickButton)
        
        gameBoardSizePickerView.delegate = self
        gameBoardSizePickerView.dataSource = self
        self.view.addSubview(gameBoardSizePickerView)
        
        //        MARK: Layout
        //        pickBoardSizeLabel Constraints
        var pickBoardSizeLabelConstraints = [NSLayoutConstraint]()
        //        TOP CONSTRAINT
        pickBoardSizeLabelConstraints.append(NSLayoutConstraint(item: pickBoardSizeLabel,
                                                                attribute: .top,
                                                                relatedBy: .equal,
                                                                toItem: view,
                                                                attribute: .topMargin,
                                                                multiplier: 1,
                                                                constant: 40))
        //        LEADING CONSTRAINT
        pickBoardSizeLabelConstraints.append(NSLayoutConstraint(item: pickBoardSizeLabel,
                                                                attribute: .leading,
                                                                relatedBy: .equal,
                                                                toItem: view,
                                                                attribute: .leading,
                                                                multiplier: 1,
                                                                constant: 10))
        //        TRAILING CONSTRAINT
        pickBoardSizeLabelConstraints.append(NSLayoutConstraint(item: pickBoardSizeLabel,
                                                                attribute: .trailing,
                                                                relatedBy: .equal,
                                                                toItem: view,
                                                                attribute: .centerX,
                                                                multiplier: 1,
                                                                constant: -5))
        //        HEIGHT CONSTRAINT
        pickBoardSizeLabelConstraints.append(NSLayoutConstraint(item: pickBoardSizeLabel,
                                                                attribute: .height,
                                                                relatedBy: .equal,
                                                                toItem: nil,
                                                                attribute: .notAnAttribute,
                                                                multiplier: 1,
                                                                constant: 80))
        pickBoardSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(pickBoardSizeLabelConstraints)
        
        
        //        pickWinChainSizeLabel Constraints
        var pickWinChainSizeLabelConstraints = [NSLayoutConstraint]()
        //        TOP CONSTRAINT
        pickWinChainSizeLabelConstraints.append(NSLayoutConstraint(item: pickWinChainSizeLabel,
                                                                   attribute: .top,
                                                                   relatedBy: .equal,
                                                                   toItem: view,
                                                                   attribute: .topMargin,
                                                                   multiplier: 1,
                                                                   constant: 40))
        //        LEADING CONSTRAINT
        pickWinChainSizeLabelConstraints.append(NSLayoutConstraint(item: pickWinChainSizeLabel,
                                                                   attribute: .leading,
                                                                   relatedBy: .equal,
                                                                   toItem: view,
                                                                   attribute: .centerX,
                                                                   multiplier: 1,
                                                                   constant: 5))
        //        TRAILING CONSTRAINT
        pickWinChainSizeLabelConstraints.append(NSLayoutConstraint(item: pickWinChainSizeLabel,
                                                                   attribute: .trailing,
                                                                   relatedBy: .equal,
                                                                   toItem: view,
                                                                   attribute: .trailing,
                                                                   multiplier: 1,
                                                                   constant: -10))
        //        HEIGHT CONSTRAINT
        pickWinChainSizeLabelConstraints.append(NSLayoutConstraint(item: pickWinChainSizeLabel,
                                                                   attribute: .height,
                                                                   relatedBy: .equal,
                                                                   toItem: nil,
                                                                   attribute: .notAnAttribute,
                                                                   multiplier: 1,
                                                                   constant: 80))
        pickWinChainSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(pickWinChainSizeLabelConstraints)
        
        
        //        pickButton Constraints
        var pickButtonConstraints = [NSLayoutConstraint]()
        //        BOTTOM CONSTRAINT
        pickButtonConstraints.append(NSLayoutConstraint(item: pickButton,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .bottom,
                                                        multiplier: 1,
                                                        constant: -20))
        //        LEADING CONSTRAINT
        pickButtonConstraints.append(NSLayoutConstraint(item: pickButton,
                                                        attribute: .leading,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .leading,
                                                        multiplier: 1,
                                                        constant: 0))
        //        TRAILING CONSTRAINT
        pickButtonConstraints.append(NSLayoutConstraint(item: pickButton,
                                                        attribute: .trailing,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: .trailing,
                                                        multiplier: 1,
                                                        constant: 0))
        //        HEIGHT CONSTRAINT
        pickButtonConstraints.append(NSLayoutConstraint(item: pickButton,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1,
                                                        constant: 50))
        pickButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(pickButtonConstraints)
        
        
        //        gameBoardSizePickerView Constraints
        var gameBoardSizePickerViewConstraints = [NSLayoutConstraint]()
        //        1st TOP CONSTRAINT
        gameBoardSizePickerViewConstraints.append(NSLayoutConstraint(item: gameBoardSizePickerView,
                                                                     attribute: .top,
                                                                     relatedBy: .equal,
                                                                     toItem: pickBoardSizeLabel,
                                                                     attribute: .bottom,
                                                                     multiplier: 1,
                                                                     constant: 40))
        //        2nd TOP CONSTRAINT
        gameBoardSizePickerViewConstraints.append(NSLayoutConstraint(item: gameBoardSizePickerView,
                                                                     attribute: .top,
                                                                     relatedBy: .equal,
                                                                     toItem: pickWinChainSizeLabel,
                                                                     attribute: .bottom,
                                                                     multiplier: 1,
                                                                     constant: 40))
        //        LEADING CONSTRAINT
        gameBoardSizePickerViewConstraints.append(NSLayoutConstraint(item: gameBoardSizePickerView,
                                                                     attribute: .leading,
                                                                     relatedBy: .equal,
                                                                     toItem: view,
                                                                     attribute: .leading,
                                                                     multiplier: 1,
                                                                     constant: 0))
        //        TRAILING CONSTRAINT
        gameBoardSizePickerViewConstraints.append(NSLayoutConstraint(item: gameBoardSizePickerView,
                                                                     attribute: .trailing,
                                                                     relatedBy: .equal,
                                                                     toItem: view,
                                                                     attribute: .trailing,
                                                                     multiplier: 1,
                                                                     constant: 0))
        //        BOTTOM CONSTRAINT
        gameBoardSizePickerViewConstraints.append(NSLayoutConstraint(item: gameBoardSizePickerView,
                                                                     attribute: .bottom,
                                                                     relatedBy: .equal,
                                                                     toItem: pickButton,
                                                                     attribute: .topMargin,
                                                                     multiplier: 1,
                                                                     constant: -25))
        gameBoardSizePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(gameBoardSizePickerViewConstraints)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerData.count
        }
        
        return ArraySlice(pickerData[0...(self.gameBoardSizePickerView.selectedRow(inComponent: 0))]).count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(pickerData[row])
        }
        
        return String(ArraySlice(pickerData[0...self.gameBoardSizePickerView.selectedRow(inComponent: 0)])[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
    }
    
    //MARK: Actions
    
    @IBAction func sizePicked(sender: UIButton){
        self.removeFromParentViewController()
        
        let newGame = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        
        newGame.setSize(size: pickerData[self.gameBoardSizePickerView.selectedRow(inComponent:0)])
        newGame.setWinChainSize(size: pickerData[self.gameBoardSizePickerView.selectedRow(inComponent: 1)])
        
        self.present(newGame, animated: true, completion: nil)
    }
    
}
