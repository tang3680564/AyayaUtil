//
//  UIView+Extension.swift
//  Uptick
//
//  Created by StarryMedia 刘晓祥 on 2019/6/17.
//  Copyright © 2019 starrymedia. All rights reserved.
//

import Foundation
import UIKit

var myNameKeys = 2

fileprivate var shadowIndex = 1

fileprivate var circleIndex = 1

fileprivate var myViewTag = 100

fileprivate var shadowLayerObseverIndex = 1

fileprivate var circleCornerRadiusIndex = 1

fileprivate var shadowLayerCornerRadiusObseverIndex = 1

public extension UIView {
    
    ///角度
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    ///边框宽度
    @IBInspectable var borderWidths: CGFloat {
        get {return layer.borderWidth}
        set {layer.borderWidth = newValue}
    }
    
    ///边框颜色
    @IBInspectable var borderColors: UIColor {
        get {return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)}
        set {layer.borderColor = newValue.cgColor}
    }
    
    ///是否控制边界
    @IBInspectable var masksToBounds: Bool{
        get {return layer.masksToBounds}
        set {layer.masksToBounds = newValue}
    }
    
    ///设置圆形的监听
    private var circleCornerRadiusObsever: NSKeyValueObservation? {
        get {
            if let obsever = objc_getAssociatedObject(self, &circleCornerRadiusIndex) as? NSKeyValueObservation {
                return obsever
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &circleCornerRadiusIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    ///设置成圆形
    @IBInspectable var circleCornerRadius: Bool{
        get{
            if let circle = objc_getAssociatedObject(self, &circleIndex) as? Bool {
                return circle
            }
            return false
        }
        set {
            if newValue {
                circleCornerRadiusObsever = self.observe(\UIView.bounds, options: .new, changeHandler: { [weak self] (view, change) in
                    if let frame = change.newValue {
                        self?.layer.cornerRadius = frame.height / 2
                    }
                })
                layer.cornerRadius = frame.height / 2
            }
            objc_setAssociatedObject(self, &circleIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    ///设置阴影的监听
    private var shadowLayerObsever: NSKeyValueObservation? {
        get {
            if let obsever = objc_getAssociatedObject(self, &shadowLayerObseverIndex) as? NSKeyValueObservation{
                return obsever
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &shadowLayerObseverIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    ///设置阴影的弧度监听
    private var shadowLayerCornerRadiusObsever: NSKeyValueObservation? {
        get {
            if let obsever = objc_getAssociatedObject(self, &shadowLayerCornerRadiusObseverIndex) as? NSKeyValueObservation{
                return obsever
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &shadowLayerCornerRadiusObseverIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    ///设置阴影
    @IBInspectable var shadowLayer: Bool {
        get {
            if let shadow = objc_getAssociatedObject(self, &shadowIndex) as? Bool {
                return shadow
            }
            return false
        }
        set{
            objc_setAssociatedObject(self, &shadowIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            if (newValue) {
                shadowLayerObsever = self.observe(\UIView.bounds, options: .new, changeHandler: { [weak self] (view, change) in
                    self?.setLayerShadow()
                })
                shadowLayerCornerRadiusObsever = self.layer.observe(\CALayer.cornerRadius, options: .new) { [weak self] (view, changeHandler) in
                    self?.setLayerShadow()
                }
            }
        }
    }
    
    ///标记哪个视图调用
    @objc var viewStrTag: String {
        get{
            if let rs = objc_getAssociatedObject(self, &myNameKeys) as? String {
                return rs
            }
            return ""
        }
        set{
            objc_setAssociatedObject(self, &myNameKeys, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    ///添加单点方法
    @discardableResult
    @objc func addTapGest(viewController: UIViewController?, selector: Selector) -> UITapGestureRecognizer {
        weak var weakSelf = self
        weakSelf!.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(viewController ?? UIViewController(), action: selector)
        weakSelf!.addGestureRecognizer(tap)
        return tap
    }
    
    ///给点击的view添加标记的单点方法
    @objc func addTapGest(viewController: UIViewController?, selector: Selector, viewTag: Int) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.viewTag = viewTag
        tap.addTarget(viewController ?? UIViewController(), action: selector)
        self.addGestureRecognizer(tap)
    }
    
    ///渐变 使用autolayout 需要再viewDidLayoutSubviews中使用
    open func addCAGradientLayer(colors: Array<CGColor>) {
        let grad = CAGradientLayer()
        grad.colors = colors
        grad.frame = frame
        grad.startPoint = CGPoint(x: 0, y: 0.5)
        grad.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(grad, at: 0)
        
    }
    ///渐变 使用autolayout 需要再viewDidLayoutSubviews中使用
    open func addCAGradientLayerInButton(colors: Array<CGColor>) {
        let grad = CAGradientLayer()
        grad.colors = colors
        grad.frame = frame
        grad.startPoint = CGPoint(x: 0, y: 0.5)
        grad.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(grad)
        
    }
    
    ///设置阴影
    open func setLayerShadow() {
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor(white: 0, alpha: 0.7).cgColor
        self.layer.shadowRadius = 2.5
        self.layer.shadowOpacity = 0.25
        let rect = self.bounds
        self.layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius).cgPath
    }
    
    ///设置虚线 使用autolayout 需要再viewDidLayoutSubviews中使用
    open func setLinView(strokeColor: UIColor) -> CAShapeLayer {
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        shapeLayer.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        shapeLayer.lineDashPattern = [NSNumber(value: 3), NSNumber(value: 2)]

        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: self.bounds.width / 2, y: 0))
        path.addLine(to: CGPoint(x: self.bounds.width / 2, y: self.bounds.height))
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
        return shapeLayer
    }
    
    ///推出当前视图控制器
    func popCurrentViewControl() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(popViewControl))
        self.addGestureRecognizer(tap)
    }
    
    @objc private func popViewControl() {
    getCurrentNavgationViewControl()?.popViewController(animated: true)
    }
    
}



extension UITapGestureRecognizer{
    ///标记哪个视图调用
    public var viewTag : Int {
        get{
            if let rs = objc_getAssociatedObject(self, &myViewTag) as? Int {
                return rs
            }
            return 0
        }
        set{
            objc_setAssociatedObject(self, &myViewTag, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
}
