//
//  SlideViewController.swift
//  LoyToken
//
//  Created by StarryMedia 刘晓祥 on 2019/10/30.
//  Copyright © 2019 Taylor. All rights reserved.
//

import UIKit

public enum SlideDirection {
    case SlideUp;
    case SlideDowm;
    case SlideLeft;
    case SlideRight;
}


public class SlideViewController: UIViewController {
    
    let kScreenWidth = UIScreen.main.bounds.size.width
    let kScreenHeight = UIScreen.main.bounds.size.height
    
    ///重写这个高度,滑动距离,上下写高度,左右写宽度
    public var viewHieght : CGFloat = 0
    
    var backGourdView : UIView?

    ///避免多次触发
    var showFlag = false
    ///滑动方向
    public var slideDirection : SlideDirection = SlideDirection.SlideUp;
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        switch self.slideDirection{
        case .SlideUp:
            self.view.frame.origin.y = kScreenHeight
        case .SlideDowm:
            self.view.frame.origin.y = -kScreenHeight
        case .SlideLeft:
            self.view.frame.origin.x = kScreenWidth
        case .SlideRight:
            self.view.frame.origin.x = -kScreenWidth
        }
    }
    
   public func addAnimation(){
        self.view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.viewDidLoad()
        self.backGourdView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.backGourdView?.backgroundColor = UIColor(white: 0, alpha: 0)
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        weak var wSelf = self
        tap.addTarget(wSelf as Any, action: #selector(hinde))
        self.backGourdView?.isUserInteractionEnabled = true
        self.backGourdView?.addGestureRecognizer(tap)
    
    }
    
   public func show(finishiDo : @escaping (() -> ()) = {}){
        guard let bview = backGourdView else{
            return
        }
        ///避免多次触发加载
        guard !showFlag else {
            return
        }
//        self.superView?.addSubview(bview)
        UIApplication.shared.keyWindow?.addSubview(bview)
        UIApplication.shared.keyWindow?.addSubview(self.view)
        showFlag = true
        UIView.animate(withDuration: 0.5, animations: {
            bview.backgroundColor = UIColor(white: 0, alpha: 0.5)
            switch self.slideDirection{
            case .SlideUp:
                self.view.transform = CGAffineTransform.init(translationX: 0, y: -self.viewHieght)
            case .SlideDowm:
                self.view.transform = CGAffineTransform.init(translationX: 0, y: self.viewHieght)
            case .SlideLeft:
                self.view.transform = CGAffineTransform.init(translationX: -self.viewHieght, y: 0)
            case .SlideRight:
                self.view.transform = CGAffineTransform.init(translationX: self.viewHieght, y: 0)
            }
        }){ (finishi) in
            finishiDo()
        }
    }
    
    @objc public func hindeDoFinish(finishiDo : @escaping (() -> ()) = {}){
        showFlag = false
        UIView.animate(withDuration: 0.5, animations: {
            self.backGourdView?.backgroundColor = UIColor(white: 0, alpha: 0)
            self.view.transform = CGAffineTransform.identity
        }) { (finishi) in
            if(finishi){
                self.backGourdView?.removeFromSuperview()
                self.view.removeFromSuperview()
            }
            finishiDo()
        }
    }
    
    @objc public func hinde(){
        showFlag = false
        UIView.animate(withDuration: 0.5, animations: {
            self.backGourdView?.backgroundColor = UIColor(white: 0, alpha: 0)
            self.view.transform = CGAffineTransform.identity
        }) { (finishi) in
            if(finishi){
                self.backGourdView?.removeFromSuperview()
                self.view.removeFromSuperview()
            }
        }
    }
    

}
