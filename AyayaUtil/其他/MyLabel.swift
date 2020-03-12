//
//  MyLabel.swift
//  Uptick
//
//  Created by StarryMedia 刘晓祥 on 2019/5/29.
//  Copyright © 2019 starrymedia. All rights reserved.
//

import Foundation
import UIKit

///可以长按复制的Label
public class MyLabel : UILabel {
    override public var canBecomeFirstResponder: Bool { return true }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        self.isUserInteractionEnabled = true
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:title:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc private func longPressAction(_ sender: UIGestureRecognizer,title : String = "复制") {
        
        guard sender.state == .began else {
            return
        }
        
        // 变为第一响应者
        self.becomeFirstResponder()
        
        // 菜单控制器
        let menuController = UIMenuController.shared
        // 复制 item
        let copyItem = UIMenuItem(title: title, action: #selector(copyText))
        // 添加 item 到 menu 控制器
        menuController.menuItems = [copyItem]
        // 设置菜单控制器点击区域为当前控件 bounds
        menuController.setTargetRect(self.bounds, in: self)
        // 菜单显示器可见
        menuController.setMenuVisible(true, animated: true)
        
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copyText) {
            return true
        }
        return false
    }
    
    @objc private func copyText() {
        UIPasteboard.general.string = self.text
    }
}
