//
//  SwizzedProto.swift
//  LoyToken
//
//  Created by Ayaya on 2020/2/17.
//  Copyright © 2020 Taylor. All rights reserved.
//

import Foundation
///方法交换协议
public protocol swizzleMethodProt {
    static func swizzleMethod(for aClass: AnyClass, originalSelector: Selector,swizzledSelector: Selector)
    
    static func swizzleClassMethod(for aClass: AnyClass, originalSelector: Selector,swizzledSelector: Selector)
    
}

extension swizzleMethodProt{
    
    public static func swizzleMethod(for aClass: AnyClass, originalSelector: Selector,swizzledSelector: Selector){
        let originalMethod = class_getInstanceMethod(aClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector)
        let addMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(originalMethod!))
        if addMethod{
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        }else{
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    public static func swizzleClassMethod(for aClass: AnyClass, originalSelector: Selector,swizzledSelector: Selector){
        let originalMethod = class_getClassMethod(aClass, originalSelector)
        let swizzledMethod = class_getClassMethod(aClass, swizzledSelector)
        let addMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(originalMethod!))
        if addMethod{
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        }else{
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
