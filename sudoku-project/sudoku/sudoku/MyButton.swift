//
//  MyButton.swift
//  sudoku
//
//  Created by Lin, Alan on 5/5/17.
//  Copyright © 2017 Lin, Alan. All rights reserved.
//

import UIKit
@IBDesignable
class MyButton: UIButton {

    public enum Defaults {
        public static var btnBorderColor: UIColor = UIColor(red: 93/255, green: 145/255, blue:174/255, alpha: 1.0)
        public static var btnBorderWidth: CGFloat = 2.0
        public static var btnCornerRadius: CGFloat = 4.0
    }
    @IBInspectable var CornerRadius: CGFloat = Defaults.btnCornerRadius {
        didSet {
            layer.cornerRadius = CornerRadius
            layer.masksToBounds = CornerRadius > 0
        }
    }
    @IBInspectable var BorderWidth: CGFloat = Defaults.btnBorderWidth {
        didSet {
            layer.borderWidth = BorderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor  = Defaults.btnBorderColor {
        didSet {
            layer.borderColor = BorderColor.cgColor
        }
    }
   
    func setUIButton() {
        self.layer.borderColor = BorderColor.cgColor
        self.layer.borderWidth = BorderWidth
        self.layer.cornerRadius = CornerRadius
        self.layer.masksToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUIButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUIButton()
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */


}
