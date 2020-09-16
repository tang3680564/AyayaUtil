//
//  UIButton+Extesion.swift
//  BURN
//
//  Created by StarryMedia 刘晓祥 on 2019/11/19.
//  Copyright © 2019 starrymedia. All rights reserved.
//

import Foundation
import UIKit

var drawRoundLayerIndex = 1;
var drawRoundAnimationFlagIndex = 1;
var pathAnimationIndex = 1;
var finishRoundIndex = 1;

extension UIButton: CAAnimationDelegate{
    
    typealias finisDrawRound = ((Bool) -> ())
    ///完成后闭包
    var finishRound : finisDrawRound?{
        set{
            return objc_setAssociatedObject(self, &finishRoundIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            if let round = objc_getAssociatedObject(self, &finishRoundIndex) as? finisDrawRound{
                return round
            }else{
                return nil
            }
        }
    }
    ///画圆的 layer 层
    var drawRoundLayer : CAShapeLayer{
        set{
            return objc_setAssociatedObject(self, &drawRoundLayerIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        get{
            if let layer = objc_getAssociatedObject(self, &drawRoundLayerIndex) as? CAShapeLayer{
                return layer
            }else{
                return CAShapeLayer()
            }
        }
    }
    
    ///判断是否重复
    var drawRoundAnimationFlag : Bool{
        set{
            return objc_setAssociatedObject(self, &drawRoundAnimationFlagIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get{
            if let flag = objc_getAssociatedObject(self, &drawRoundAnimationFlagIndex) as? Bool{
                return flag
            }
            return false;
        }
    }
    ///动画
    var pathAnimation : CABasicAnimation{
        set{
            return objc_setAssociatedObject(self, &pathAnimationIndex, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        get{
            if let animation = objc_getAssociatedObject(self, &pathAnimationIndex) as? CABasicAnimation{
                return animation
            }
            else{
                return CABasicAnimation()
            }
        }
    }
    
    
    
    ///初始化画圆的动画和 layer 层
    ///
    /// - Parameters:
    ///   - strokeColor: 圆的颜色
    ///   - lineWidth: 圆的宽度
    ///   - duration: 动画时间
    ///   - finish: 动画完成后调用
    @objc func drawRoundInButton(strokeColor : UIColor = UIColor.white ,lineWidth : CGFloat  = 1 , duration : CFTimeInterval = 3,finish : @escaping finisDrawRound ){
        // 贝塞尔曲线(创建一个圆)
        let roundPath = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.width / 2), radius: frame.width / 2, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(Double.pi*1.5), clockwise: true)
        drawRoundLayer = CAShapeLayer()
        // 与showView的frame一致
        drawRoundLayer.frame         = bounds;
        // 边缘线的颜色
        drawRoundLayer.strokeColor   = strokeColor.cgColor
        // 闭环填充的颜色
        drawRoundLayer.fillColor     = UIColor.clear.cgColor
        // 边缘线的类型
        drawRoundLayer.lineCap       = .square;
        // 从贝塞尔曲线获取到形状
        drawRoundLayer.path          = roundPath.cgPath;
         // 线条宽度
        drawRoundLayer.lineWidth     = lineWidth;
        drawRoundLayer.strokeStart   = 0.0;
        drawRoundLayer.strokeEnd     = 0.0;
        // 将layer添加进图层
        self.layer.addSublayer(drawRoundLayer)
        
        ///初始化标志
        drawRoundAnimationFlag = false;
        // 给这个layer添加动画效果
        pathAnimation = CABasicAnimation(keyPath: "strokeEnd");
        ///动画时间
        pathAnimation.duration = duration;
        ///开始结束位置
        pathAnimation.fromValue = 0;
        pathAnimation.toValue = 1;
        pathAnimation.isRemovedOnCompletion = true;
        pathAnimation.delegate = self;
        pathAnimation.fillMode = .forwards;
        ///逃逸闭包,动画完成后调用
        finishRound = finish
        ///添加两个按钮事件
        ///按下事件
        addTarget(self, action: #selector(downTouch), for: .touchDown)
        ///松开事件
        addTarget(self, action: #selector(cancelTouch), for: .touchUpInside)
    }
    
   
    @objc func downTouch(){
        ///避免多次触发
        if(!drawRoundAnimationFlag){
            drawRoundAnimationFlag = true
            ///按下开始动画
            drawRoundLayer.add(pathAnimation, forKey: "drawRoundAnimation");
        }
    }
    
    @objc func cancelTouch(){
        ///松开删除动画
        if(drawRoundAnimationFlag){
            drawRoundAnimationFlag = false
            drawRoundLayer.removeAnimation(forKey: "drawRoundAnimation")
        }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        finishRound?(flag)
    }
    
    
}
