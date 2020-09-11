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
private var languageObsertIndex = 2
private var setLanguageFlagIndex = 3

extension UILabel {
    
    ///多语言设置开关
    @IBInspectable var languageSet: Bool {
        set {
            objc_setAssociatedObject(self, &languageSetIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            if (newValue) {
                languageObsert = self.observe(\.text, options: .initial, changeHandler: { [weak self] (label, change) in
                    self?.setLanguage()
                })
            }
        }
        get {
            if let language = objc_getAssociatedObject(self, &languageSetIndex) as? Bool {
                return language
            }
            return true
        }
    }
    
    private var languageObsert: NSKeyValueObservation? {
        set {
            objc_setAssociatedObject(self, &languageObsertIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let obsert = objc_getAssociatedObject(self, &languageObsertIndex) as? NSKeyValueObservation {
                return obsert
            }
            return nil
        }
    }
    
    private var setLanguageFlag: Bool {
        set {
            objc_setAssociatedObject(self, &setLanguageFlagIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let setLanguage = objc_getAssociatedObject(self, &setLanguageFlagIndex) as? Bool{
                return setLanguage
            }
            return false
        }
    }
    
    func setLanguage() {
        print("UILabel语言设置\(text)")
        if (!setLanguageFlag) {
            setLanguageFlag = true
            text = text?.getLabel()
        }
    }
}
