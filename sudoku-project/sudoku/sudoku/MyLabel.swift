//
//  MyLabel.swift
//  sudoku
//
//  Created by Lin, Alan on 5/8/17.
//  Copyright © 2017 Lin, Alan. All rights reserved.
//

import UIKit

@IBDesignable
class MyLabel: UILabel {
    
    public enum Defaults {
        public static var borderColor: UIColor = UIColor(red: 156/255, green: 179/255, blue:82/255, alpha: 1.0)
        public static var borderWidth: CGFloat = 1.0
        public static var cornerRadius: CGFloat = 0.0
    }
    
    @IBInspectable var cornerRadius: CGFloat = Defaults.cornerRadius {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = Defaults.borderWidth {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor  = Defaults.borderColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    
    func setMyLabel() {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setMyLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setMyLabel()
    }
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
