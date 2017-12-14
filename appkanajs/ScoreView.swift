//
//  ScoreView.swift
//  appkanajs
//
//  Created by Martin Gábor on 11/12/2017.
//  Copyright © 2017 Martin Gábor. All rights reserved.
//
import UIKit

protocol ScoreViewProtocol: NSObjectProtocol {
    func setupInitConstraints()
}


class ScoreView: UIView {
    
    @IBOutlet var crossCountLabel: UILabel!
    @IBOutlet var circleCountLabel: UILabel!
    @IBOutlet var winChainSizeLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var crossCounterPictureView: TicTacImageView!
    @IBOutlet var circleCounterPictureView: TicTacImageView!
    
    let offset: Int = Int((UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.width) * 0.8)//80% of screen size
    let buttonWidth: Int = Int(UIScreen.main.bounds.size.width/3)
    private var parent: UIView!
    
    weak var delegate: WinViewProtocol? = nil
    weak var delegate2: GameBoardViewProtocol? = nil
    weak var delegate3: ScoreViewProtocol? = nil
    
    
    
    var whiteCoverView: UIView!
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(winChainSize: String) {
        let frame = CGRect(x: 0, y: 0, width: width, height: CGFloat(offset))
        
        super.init(frame: frame)
        //self.delegate3?.setupInitConstraints()
        
        //        add white background to whiteCoverView
        //        this is our bottom layer of Score Board View
        whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height:0))
        whiteCoverView.backgroundColor = .white
        
        self.addSubview(whiteCoverView)
        
        
        
        
        //        add image subview to the left/right side of scoreboard (whiteCoverView)
        //        cross image first
        let crossCounterPicture = UIImage(named: "Cross.png")// normal state
        crossCounterPictureView = TicTacImageView(frame: CGRect(x: 2, y: 2, width: buttonWidth - 4, height: buttonWidth - 4))
        crossCounterPictureView.image = crossCounterPicture
        
        whiteCoverView.addSubview(crossCounterPictureView)
        
        //        then circle image
        let circleCounterPicture = UIImage(named: "Circle.png") // normal sate
        
        circleCounterPictureView = TicTacImageView(frame: CGRect(x: 2 * buttonWidth + 2, y: 2, width: buttonWidth - 4, height: buttonWidth - 4))
        circleCounterPictureView.image = circleCounterPicture
        whiteCoverView.addSubview(circleCounterPictureView)
        //cross starts
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
        
        
        
        
        winChainSizeLabel = UILabel(/*frame: CGRect(x: buttonWidth + 2, y: offset - 70, width: buttonWidth - 4, height: 40)*/)
        winChainSizeLabel.text = "Win Chain Size: " + winChainSize
        winChainSizeLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        winChainSizeLabel.lineBreakMode = .byWordWrapping
        winChainSizeLabel.numberOfLines = 0
        self.addSubview(winChainSizeLabel)
        
        resetButton = UIButton(/*frame: CGRect(x: buttonWidth + 2, y: 55, width: buttonWidth - 4, height: buttonWidth - 54)*/)
        resetButton.addTarget(self, action: #selector(ScoreView.resetCounters(sender:)), for: .touchUpInside)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        resetButton.setTitleColor(UIColor.black, for: .normal)
        resetButton.layer.borderWidth = 4
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.cornerRadius = 25
        resetButton.isUserInteractionEnabled = true
        whiteCoverView.addSubview(resetButton)
        
        var resetButtonConstraints = [NSLayoutConstraint]()
        resetButtonConstraints.append(NSLayoutConstraint(item: resetButton,
                                                         attribute: .top,
                                                         relatedBy: .equal,
                                                         toItem: whiteCoverView,
                                                         attribute: .top,
                                                         multiplier: 1,
                                                         constant: 5))
        resetButtonConstraints.append(NSLayoutConstraint(item: resetButton,
                                                         attribute: .centerX,
                                                         relatedBy: .equal,
                                                         toItem: whiteCoverView,
                                                         attribute: .centerX,
                                                         multiplier: 1,
                                                         constant: 5))
        resetButtonConstraints.append(NSLayoutConstraint(item: resetButton,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: crossCounterPictureView,
                                                         attribute: .width,
                                                         multiplier: 1,
                                                         constant: -5))
        resetButtonConstraints.append(NSLayoutConstraint(item: resetButton,
                                                         attribute: .bottom,
                                                         relatedBy: .equal,
                                                         toItem: whiteCoverView,
                                                         attribute: .bottom,
                                                         multiplier: 1,
                                                         constant: -5))
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(resetButtonConstraints)
        
        setConstraints()
        
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            print("background color is being set")
            if whiteCoverView.backgroundColor == UIColor.clear {
                print("set to a clear color")
                whiteCoverView.backgroundColor = UIColor.white
            }
        }
    }
    
    func setConstraints(){
        var whiteCoverViewConstraints = [NSLayoutConstraint]()
        whiteCoverViewConstraints.append(NSLayoutConstraint(item: whiteCoverView,
                                                            attribute: .top,
                                                            relatedBy: .equal,
                                                            toItem: self,
                                                            attribute: .topMargin,
                                                            multiplier: 1,
                                                            constant: 0))
        whiteCoverViewConstraints.append(NSLayoutConstraint(item: whiteCoverView,
                                                            attribute: .width,
                                                            relatedBy: .equal,
                                                            toItem: nil,
                                                            attribute: .notAnAttribute,
                                                            multiplier: 1,
                                                            constant: width))
        whiteCoverViewConstraints.append(NSLayoutConstraint(item: whiteCoverView,
                                                            attribute: .height,
                                                            relatedBy: .equal,
                                                            toItem: nil,
                                                            attribute: .notAnAttribute,
                                                            multiplier: 1,
                                                            constant: CGFloat(buttonWidth)))
        whiteCoverView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(whiteCoverViewConstraints)
        
        var crossCountLabelConstraints = [NSLayoutConstraint]()
        crossCountLabelConstraints.append(NSLayoutConstraint(item: crossCountLabel,
                                                             attribute: .top,
                                                             relatedBy: .greaterThanOrEqual,
                                                             toItem: whiteCoverView,
                                                             attribute: .bottom,
                                                             multiplier: 1,
                                                             constant: 10))
        crossCountLabelConstraints.append(NSLayoutConstraint(item: crossCountLabel,
                                                             attribute: .leading,
                                                             relatedBy: .equal,
                                                             toItem: self,
                                                             attribute: .leading,
                                                             multiplier: 1,
                                                             constant: 0))
        crossCountLabelConstraints.append(NSLayoutConstraint(item: crossCountLabel,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: crossCounterPictureView,
                                                             attribute: .width,
                                                             multiplier: 1,
                                                             constant: 0))
        
        var winChainSizeLabelConstraints = [NSLayoutConstraint]()
        winChainSizeLabelConstraints.append(NSLayoutConstraint(item: winChainSizeLabel,
                                                               attribute: .top,
                                                               relatedBy: .greaterThanOrEqual,
                                                               toItem: whiteCoverView,
                                                               attribute: .bottom,
                                                               multiplier: 1,
                                                               constant: 10))
        winChainSizeLabelConstraints.append(NSLayoutConstraint(item: winChainSizeLabel,
                                                               attribute: .leading,
                                                               relatedBy: .equal,
                                                               toItem: crossCountLabel,
                                                               attribute: .trailing,
                                                               multiplier: 1,
                                                               constant: 5))
        winChainSizeLabelConstraints.append(NSLayoutConstraint(item: winChainSizeLabel,
                                                               attribute: .trailing,
                                                               relatedBy: .equal,
                                                               toItem: circleCountLabel,
                                                               attribute: .leading,
                                                               multiplier: 1,
                                                               constant: 5))

        var circleCountLabelConstraints = [NSLayoutConstraint]()
        circleCountLabelConstraints.append(NSLayoutConstraint(item: circleCountLabel,
                                                              attribute: .top,
                                                              relatedBy: .greaterThanOrEqual,
                                                              toItem: whiteCoverView,
                                                              attribute: .bottom,
                                                              multiplier: 1,
                                                              constant: 10))
        circleCountLabelConstraints.append(NSLayoutConstraint(item: circleCountLabel,
                                                              attribute: .trailing,
                                                              relatedBy: .equal,
                                                              toItem: self,
                                                              attribute: .trailing,
                                                              multiplier: 1,
                                                              constant: 0))
        circleCountLabelConstraints.append(NSLayoutConstraint(item: circleCountLabel,
                                                              attribute: .width,
                                                              relatedBy: .equal,
                                                              toItem: circleCounterPictureView,
                                                              attribute: .width,
                                                              multiplier: 1,
                                                              constant: 0))
        
        winChainSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        circleCountLabel.translatesAutoresizingMaskIntoConstraints = false
        crossCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(crossCountLabelConstraints + circleCountLabelConstraints + winChainSizeLabelConstraints)
        
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



