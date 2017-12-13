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
        
        let infoLabel = UILabel(frame: CGRect(x: 0, y: 60, width: Int(width), height: 60))
        infoLabel.text = "Choose your gameboard size"
        infoLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 25)
        infoLabel.textAlignment = .center
        self.view.addSubview(infoLabel)
        pickerData = [3,4,5,6,7,8,9]
        
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
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[row])
    }
    
    //MARK: Actions
    
    @IBAction func sizePicked(sender: UIButton){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let newGame = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        newGame.setSize(size: pickerData[self.gameBoardSizePickerView.selectedRow(inComponent: 0)])
        
        
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
