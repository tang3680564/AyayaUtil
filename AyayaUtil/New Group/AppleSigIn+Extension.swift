//
//  AppleSigInDelegate.swift
//  singeInAppleDemo
//
//  Created by Ayaya on 2020/2/3.
//  Copyright © 2020 Ayaya. All rights reserved.
//

import Foundation
import AuthenticationServices

private var sigInResultIndex = 0

@available(iOS 13.0, *)
extension ASAuthorizationAppleIDButton{
    
    typealias AppleUser = ((ASAuthorizationAppleIDCredential) -> Void)
    ///结果回调
    var sigInResult : AppleUser?{
        get{
            if let result = objc_getAssociatedObject(self, &sigInResultIndex) as? AppleUser{
                return result
            }
            return nil
        }
        
        set{
            objc_setAssociatedObject(self, &sigInResultIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    ///添加点击方法
    func addSigInButton(getSigInResult : @escaping AppleUser){
        self.addTarget(self, action: #selector(handleAuthorization), for: .touchUpInside)
        self.sigInResult = getSigInResult
    }
    
    ///点击实现
    @objc func handleAuthorization(){
           let requestID = ASAuthorizationAppleIDProvider().createRequest()
                  // 这里请求了用户的姓名和email
                  requestID.requestedScopes = [.fullName, .email]
                  
                  let controller = ASAuthorizationController(authorizationRequests: [requestID])
                  controller.delegate = self
                  controller.presentationContextProvider = self
                  controller.performRequests()
       }
    
}

///登陆代理
@available(iOS 13.0, *)
extension ASAuthorizationAppleIDButton : ASAuthorizationControllerDelegate{
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 请求完成，但是有错误
    }
    
    public func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization)
    {
        // 请求完成， 用户通过验证
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential
        {
            // 拿到用户的验证信息，这里可以跟自己服务器所存储的信息进行校验，比如用户名是否存在等。
            self.sigInResult?(credential)
            
        }
    }
}

@available(iOS 13.0, *)
extension ASAuthorizationAppleIDButton : ASAuthorizationControllerPresentationContextProviding{
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.delegate!.window!!
    }
    
    
}

@available(iOS 13.0, *)
protocol AppleSigInDelegate{
    typealias AppleUser = ((ASAuthorizationAppleIDCredential) -> Void)
    func getSigInButton(getSigInResult : @escaping AppleUser)  -> ASAuthorizationAppleIDButton
}

@available(iOS 13.0, *)
extension AppleSigInDelegate{
    func getSigInButton(getSigInResult : @escaping AppleUser) -> ASAuthorizationAppleIDButton{
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
        button.addSigInButton { (result) in
            getSigInResult(result)
        }
        return button
    }
}
