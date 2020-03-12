//
//  UpDownView.swift
//  ZHFToolBox
//
//  Created by 张海峰 on 2019/2/21.
//  Copyright © 2019年 张海峰. All rights reserved.
//
/*该demo是和大家分享一下，在项目中集成一个日历弹窗，用自己可想到的最少代码实现日历弹窗
 当然这个弹窗也是我自定义弹窗的极小部分，对Swift弹窗感兴趣的帅哥美女，可戳下面链接
 https://github.com/FighterLightning/ZHFToolBox.git
 */
import UIKit
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width
public class UpDownView: UIView ,UIGestureRecognizerDelegate{
    //白色view用来装一些控件
    var WhiteView: UIView =  UIView()
    var whiteViewStartFrame: CGRect = CGRect.init(x: 0, y: ScreenHeight, width: ScreenWidth, height: 450)
    var whiteViewEndFrame: CGRect = CGRect.init(x: 0, y: ScreenHeight - 450, width: ScreenWidth, height: 450)
    //确定按钮
    var okBtn: UIButton = UIButton()
    //背景区域的颜色和透明度
    var backgroundColor1:UIColor  = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
    var defaultTime:CGFloat = 0.5
    //初始化视图
    func initPopBackGroundView() -> UIView {
        self.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.backgroundColor = backgroundColor1
        self.isHidden = true
        //设置添加地址的View
        self.WhiteView.frame = whiteViewStartFrame
        WhiteView.backgroundColor = UIColor.white
        self.addSubview(WhiteView)
        //添加点击手势
        let tap: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapBtnAndcancelBtnClick))
        tap.delegate = self
        self.addGestureRecognizer(tap)
        okBtn = UIButton.init(type: UIButton.ButtonType.custom)
        okBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        let width = "wallet_cancel".getLabel().getNormalStrW(strFont: 15, h: 40) + 20
        okBtn.frame = CGRect.init(x:ScreenWidth - width - 20 , y: 10, width: width, height: 40)
        okBtn.tag = 1
        okBtn.setTitle("wallet_cancel".getLabel(), for: UIControl.State.normal)
        okBtn.setTitleColor(ZHFColor.zhf_color(withHex: 0x42D2BE), for: UIControl.State.normal)
        okBtn.addTarget(self, action: #selector(tapBtnAndcancelBtnClick), for: UIControl.Event.touchUpInside)
        WhiteView.addSubview(okBtn)
        return self
    }
    //弹出的动画效果
    func addAnimate() {
        
    }
    //收回的动画效果
    @objc func tapBtnAndcancelBtnClick() {
        for view in WhiteView.subviews {
            view.removeFromSuperview()
        }
        UIView.animate(withDuration: TimeInterval(defaultTime), animations: {
            self.WhiteView.frame = self.whiteViewStartFrame
        }) { (_) in
            self.isHidden = true
        }
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        //点击WhiteView不回收
        if (touch.view?.isDescendant(of: self.WhiteView))!{
            return false
        }
        return true
    }
}
