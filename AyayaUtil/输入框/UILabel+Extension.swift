//
//  UILabel+Extension.swift
//  AyayaUtil
//
//  Created by ayaya on 2020/9/11.
//  Copyright © 2020 Ayaya. All rights reserved.
//

import Foundation
import UIKit

private var languageSetIndex = 1

public extension UILabel {

    override func awakeFromNib() {
        languageSet = true
        super.awakeFromNib()
    }
    
    ///多语言设置开关
    @IBInspectable var languageSet: Bool {
        set {
            objc_setAssociatedObject(self, &languageSetIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            if (newValue) {
                self.setLanguage()
            }
        }
        get {
            if let language = objc_getAssociatedObject(self, &languageSetIndex) as? Bool {
                return language
            }
            return true
        }
    }

    func setLanguage() {
        text = text?.getLabel()
    }
}
