//
//  String+Extension.swift
//  Uptick
//
//  Created by StarryMedia 刘晓祥 on 2019/5/5.
//  Copyright © 2019 starrymedia. All rights reserved.
//

import Foundation
import CommonCrypto
import CoreGraphics
import UIKit

public struct Language {
    public static var languageTableName = ""
}

extension String {
    
    public func getLabel() -> String {
        guard let path = Bundle.main.path(forResource: "", ofType: "strings") else {
            return self
        }
        let tableNameArr = path.components(separatedBy: "/");
        guard tableNameArr.count > 0 else {
            return self
        }
        let tableNameStrArr = tableNameArr[tableNameArr.count - 1].components(separatedBy: ".");
        guard tableNameStrArr.count > 0 else {
            return self
        }
        if Language.languageTableName.isEmpty {
            let nowStr = NSLocalizedString(self, tableName: tableNameStrArr[0], bundle: Bundle.main, value: "", comment: "")
            return nowStr;
        }
        let nowStr = NSLocalizedString(self, tableName: Language.languageTableName, bundle: Bundle.main, value: "", comment: "")
        return nowStr;
        
    }
    
    
    /// 检测String是否为空或者空串
    /// - Parameter str: 检测的String
    public static func cheackStringIsNoBlank(str : String?) -> Bool{
        if(str == nil || str == ""){
            return false
        }
        if str!.isEmpty{
            return false
        }
        return true
    }
    
    
    /// 检测是否是数字
    public func cheackIsNumber() -> Bool{
        let pattern = "^[0-9]+$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    
    /// 检测电话号码
    public func cheackIsMobPhone() -> Bool{
        let pattern = "((^(13|14|15|16|17|18|19)[0-9]{9}$)|(^0[1,2]{1}\\d{1}-?\\d{8}$)|(^0[3-9] {1}\\d{2}-?\\d{7,8}$)|(^0[1,2]{1}\\d{1}-?\\d{8}-(\\d{1,4})$)|(^0[3-9]{1}\\d{2}-? \\d{7,8}-(\\d{1,4})$))"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    
    /// 检测邮箱是否正确
    public func cheackEmail() -> Bool{
        let pattern = "^[A-Za-z\\d]+([-_.][A-Za-z\\d]+)*@([A-Za-z\\d]+[-.])+[A-Za-z\\d]{2,4}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    
    /// 检测是否符合输入金额位数
    /// - Parameter dicimal: 位数，默认2位
    public func cheackIsPrice(dicimal : Int = 2) -> Bool{
        let patterns = "^[0-9]+$"
        let pattern = "^\\d+(\\.\\d{0,\(dicimal)})?$"
        let result = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self) || NSPredicate(format: "SELF MATCHES %@", patterns).evaluate(with: self)
        return result
    }
    
    
    ///获取字符串高度H
    public func getNormalStrH(str: String, strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: str, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    ///获取字符串高度H
    public func getNormalStrH(strFont: CGFloat, w: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: w, h: CGFloat.greatestFiniteMagnitude).height
    }
    
    ///获取字符串宽度
    public func getNormalStrW(strFont: CGFloat, h: CGFloat) -> CGFloat {
        return getNormalStrSize(str: self, font: strFont, w: CGFloat.greatestFiniteMagnitude, h: h).width
    }
    
    /**获取字符串尺寸--私有方法*/
    private func getNormalStrSize(str: String? = nil, attriStr: NSMutableAttributedString? = nil, font: CGFloat, w: CGFloat, h: CGFloat) -> CGSize {
        if str != nil {
            let strSize = (str! as NSString).boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)], context: nil).size
            return strSize
        }
        
        if attriStr != nil {
            let strSize = attriStr!.boundingRect(with: CGSize(width: w, height: h), options: .usesLineFragmentOrigin, context: nil).size
            return strSize
        }
        
        return CGSize(width: 0, height: 0)
        
    }
    
    ///设置小数位
    public func setPriceDecimal(dicimal : Int) -> String{
        var priceStr = ""
        let oldStr = String(self)
        let numberFormatter = NumberFormatter()
        if let _ = Double(oldStr){
            let price = NSNumber(value: Double(oldStr)!)
            //设置固定小数位
            numberFormatter.minimumFractionDigits = dicimal
            numberFormatter.maximumFractionDigits = dicimal
            //设置最小整数
            numberFormatter.minimumIntegerDigits = 1
            //        numberFormatter.usesGroupingSeparator = true //设置用组分隔
            //        numberFormatter.groupingSeparator = "," //分隔符号
            //        numberFormatter.groupingSize = 3  //分隔位数
            if let _ = numberFormatter.string(from: price){
                priceStr = numberFormatter.string(from: price)!
            }else{
                return oldStr
            }
            
        }else{
            return oldStr
        }
        
        return priceStr
    }
    
    public func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        let md5Str = String(format: hash as String)
        return md5Str.uppercased()
    }

}

