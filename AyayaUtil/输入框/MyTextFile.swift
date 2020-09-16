//
//  MyTextFile.swift
//  Uptick
//
//  Created by StarryMedia 刘晓祥 on 2019/4/25.
//  Copyright © 2019 starrymedia. All rights reserved.
//

import Foundation
import UIKit

public class MyTextFile : UITextField{
    
    private var leftWidth : CGFloat = 15
    
    @IBInspectable
    var paddingLeft: CGFloat {
        get { return leftWidth }
        set { leftWidth = newValue }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftWidth, height: 0))
        leftViewMode = UITextField.ViewMode.always

    }
    
    public override func drawPlaceholder(in rect: CGRect) {
        let rectS = rect
        
        super.drawPlaceholder(in: rectS)
    }

    
    
}


