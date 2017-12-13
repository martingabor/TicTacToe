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
let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width)/1.25)


class GameBoardPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var gameBoardSizePickerView: UIPickerView = UIPickerView()
    
    var pickerData: [Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickBoardSizeLabel = UILabel(frame: CGRect(x: 0, y: 60, width: Int(width/2), height: 60))
        pickBoardSizeLabel.text = "Game Board size"
        pickBoardSizeLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
        pickBoardSizeLabel.lineBreakMode = .byWordWrapping
        pickBoardSizeLabel.numberOfLines = 0
        pickBoardSizeLabel.textAlignment = .center
        self.view.addSubview(pickBoardSizeLabel)
        
        let pickWinChainSizeLabel = UILabel(frame: CGRect(x: Int(width/2), y: 60, width: Int(width/2), height: 60))
        pickWinChainSizeLabel.text = "Win Chain size"
        pickWinChainSizeLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
        pickWinChainSizeLabel.lineBreakMode = .byWordWrapping
        pickWinChainSizeLabel.numberOfLines = 0
        pickBoardSizeLabel.textAlignment = .center
        self.view.addSubview(pickWinChainSizeLabel)
        
        pickerData = [3,4,5,6,7,8]
        
        gameBoardSizePickerView = UIPickerView(frame: CGRect(x: 0, y: 130, width: Int(width), height: Int(width)))
        gameBoardSizePickerView.delegate = self
        gameBoardSizePickerView.dataSource = self
        
        self.view.addSubview(gameBoardSizePickerView)
        
        
        let pickButton = UIButton(frame: CGRect(x: 0, y: offset + Int(width), width: Int(width), height: 50))
        pickButton.setTitle("Pick size", for: .normal)
        pickButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        pickButton.backgroundColor = UIColor.red
        
        pickButton.addTarget(self, action: #selector(GameBoardPickerViewController.sizePicked(sender:)), for: .touchUpInside)
        self.view.addSubview(pickButton)
        
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
        print(self.gameBoardSizePickerView.selectedRow(inComponent: 0))
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
