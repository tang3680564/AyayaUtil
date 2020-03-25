//
//  NSObject+Extesion.swift
//  Uptick
//
//  Created by Ayaya on 2020/2/7.
//  Copyright © 2020 starrymedia. All rights reserved.
//

import Foundation
import UIKit

extension NSObject{
    
    public func getCurrentNavgationViewControl() -> UINavigationController?{
        print(UIApplication.shared)
        print(UIApplication.shared.keyWindow)
        print(UIApplication.shared.keyWindow?.rootViewController)
        if let tabBar = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController{
            let selectIndex = tabBar.selectedIndex
            let viewControls = tabBar.viewControllers?[selectIndex] as? UINavigationController
            return viewControls
        }
        else if let viewControls = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController{
            return viewControls
        }
        return nil
    }
    
    public func getCurrentViewControl() -> UIViewController?{
        if let tabBar = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController{
            let selectIndex = tabBar.selectedIndex
            let viewControls = tabBar.viewControllers?[selectIndex] as? UINavigationController
            if let vcArr = viewControls?.viewControllers{
                return vcArr[vcArr.count - 1]
            }
            return nil
        }else if let viewControls = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController{
            let vcArr = viewControls.viewControllers
            return vcArr[vcArr.count - 1]
        }
        return nil
    }
    
    public func getNibHeight(name : String) -> CGFloat{
        if let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil){
            if views.count > 0 {
                if let view = views[0] as? UIView{
                    return view.frame.height
                }
            }
        }
        return 0
    }
}

