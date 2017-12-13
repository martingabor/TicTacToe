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

class GameBoardPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var gameBoardSizePickerView: UIPickerView!
    
    var gameBoardSizePickerViewData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.text = "Drogy"
        label.textColor = UIColor.black
        self.view.addSubview(label)
        
        gameBoardSizePickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        gameBoardSizePickerView.backgroundColor = UIColor.red
        
        gameBoardSizePickerView.delegate = self
        gameBoardSizePickerView.dataSource = self
        
        gameBoardSizePickerViewData = ["Item 1","Item 2"]
        //self.view.addSubview(gameBoardSizePickerView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gameBoardSizePickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gameBoardSizePickerViewData[row]
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
