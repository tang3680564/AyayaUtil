//
//  LAPolicyUtil.swift
//  Uptick
//
//  Created by StarryMedia 刘晓祥 on 2019/6/12.
//  Copyright © 2019 starrymedia. All rights reserved.
//

import Foundation
import LocalAuthentication
///指纹识别,脸部识别
public class LAPolicyUtil: NSObject {
    var context : LAContext!
    var canTouchID : Bool = false
    required override init() {
        super.init()
        self.context = LAContext()
        let error : NSErrorPointer = nil
        ///判断设备是否可以使用 touchID 和 faceID
        weak var weakContext = context
        if (error != nil){
            print(error.hashValue)
        }
        //如果可以使用的话
        if(weakContext!.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: error)){
            context.localizedFallbackTitle = ""
            canTouchID = true
        }else{
            canTouchID = false
        }
       
    }
    
    /// 开始识别
    ///
    /// - Parameter touchID:识别回调
    public func beginTouchId(touchID : @escaping ((Bool) -> Void),localizedReason : String = "验证身份"){
        DispatchQueue.main.async {
            self.context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: localizedReason) { (success, error) in
                ///验证成功
                if(success){
                    DispatchQueue.main.async {
                        
                    }
                    touchID(true)
                }else{
                    print(error?.localizedDescription as Any)
                    touchID(false)
                }
            }
        }
    }
}
