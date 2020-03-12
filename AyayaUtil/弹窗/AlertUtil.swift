//
//  AlertUtil.swift
//  Uptick
//
//  Created by StarryMedia 刘晓祥 on 2019/4/25.
//  Copyright © 2019 starrymedia. All rights reserved.
//
import UIKit

class AlertUtil{
    
    static func alertMessage(message : String,comfirMessage : String = "确定"){
        let alert = UIAlertView()
        alert.message = message
        alert.addButton(withTitle: comfirMessage)
        alert.show()
    }
    
    static func alertActionMessage(title : String ,message : String,trueTitle : String, cancelTitle : String,trueAction : Selector,viewControl : UIViewController? ) -> UIAlertController{
        let alerts = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionTrue = UIAlertAction(title: trueTitle, style: .default) { (action) in
            viewControl?.performSelector(onMainThread: trueAction, with: "", waitUntilDone: false)
        }
        let actionCancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            
        }
        alerts.addAction(actionTrue)
        alerts.addAction(actionCancel)
        return alerts
    }
}
