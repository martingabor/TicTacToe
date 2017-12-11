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
    
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    
    let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width)/1.25)
    let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/3)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: Int(width), height: buttonWidth + 45))
        whiteCoverView.backgroundColor = UIColor.white
        self.addSubview(whiteCoverView)
        
        let crossCounterPicture = UIImage(named: "Cross.png")
        let crossCounterPictureView = UIImageView(frame: CGRect(x: 2, y: 25, width: buttonWidth - 4, height: buttonWidth - 4))
        crossCounterPictureView.image = crossCounterPicture
        whiteCoverView.addSubview(crossCounterPictureView)
        
        let circleCounterPicture = UIImage(named: "Circle.png")
        let circleCounterPictureView = UIImageView(frame: CGRect(x: 2 * buttonWidth + 2, y: 25, width: buttonWidth - 4, height: buttonWidth - 4))
        circleCounterPictureView.image = circleCounterPicture
        whiteCoverView.addSubview(circleCounterPictureView)
        
        //UICounterl initial setup
        crossCountLabel = UILabel(frame: CGRect(x: 2, y: offset - 70, width: buttonWidth - 4, height: 40))
        crossCountLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        crossCountLabel.textAlignment = .center
        
        circleCountLabel = UILabel(frame: CGRect(x:  2 * buttonWidth + 2, y: offset - 70, width: buttonWidth - 4, height: 40))
        circleCountLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 40)
        circleCountLabel.textAlignment = .center
        
        
        self.addSubview(crossCountLabel)
        self.addSubview(circleCountLabel)
        
        crossCountLabel.text = "0"
        circleCountLabel.text = "0"
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func change(crossCount:Int, circleCount: Int) {
        self.crossCountLabel.text = String(crossCount)
        self.circleCountLabel.text = String(circleCount)
    }
    
}
