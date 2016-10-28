//
//  RoundLabel.swift
//  SwiftTime
//
//  Created by Brian Lane on 10/27/16.
//  Copyright © 2016 Brian Lane. All rights reserved.
//

import UIKit

@IBDesignable
class RoundLabel: UILabel {
    
    @IBInspectable var inset: CGFloat = 0
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }

}
