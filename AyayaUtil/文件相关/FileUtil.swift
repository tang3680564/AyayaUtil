//
//  FileUtil.swift
//  Uptick
//
//  Created by StarryMedia 刘晓祥 on 2019/4/24.
//  Copyright © 2019 starrymedia. All rights reserved.
//

import Foundation
import UIKit

///文件操作相关
public class FileUtil : NSObject{
    
    
    /// 查询文件在Documents下面是否存在
    /// - Parameter fileName: 文件名称
    public static func fileExists(fileName : String) -> Bool{
        let homeDir = NSHomeDirectory() as NSString
        let path = homeDir.appendingPathComponent("Documents") as NSString
        let filePath = path.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    
    /// 查询在Documents下面的图片是否存在
    /// - Parameter fileName: 图片名称
    public static func imageExists(fileName : String) -> Bool{
        let homeDir = NSHomeDirectory() as NSString
        let path = homeDir.appendingPathComponent("Documents") as NSString
        let imagePath = path.appendingPathComponent("image") as NSString
        let filePath = imagePath.appendingPathComponent(fileName + ".png")
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    
    /// 获取Documents下面的图片全路径
    /// - Parameter fileName: 图片名称
    public static func getImageFilePath(fileName : String) -> String{
        let homeDir = NSHomeDirectory() as NSString
        let path = homeDir.appendingPathComponent("Documents") as NSString
        let imagePath = path.appendingPathComponent("image") as NSString
        let filePath = imagePath.appendingPathComponent(fileName + ".png")
        return filePath
    }
    
    
    /// 存储图片到Documents下
    /// - Parameters:
    ///   - image: 图片对象
    ///   - fileName: 存储的图片名称
    public static func saveImage(image : UIImage,fileName : String){
        let data = image.pngData() as NSData?
        let homeDir = NSHomeDirectory() as NSString
        let path = homeDir.appendingPathComponent("Documents") as NSString
        let imagePath = path.appendingPathComponent("image") as NSString
        var isDirectory: ObjCBool = false
        let dirExists = FileManager.default.fileExists(atPath: imagePath as String, isDirectory: &isDirectory)
        
        if(!dirExists){
            try! FileManager.default.createDirectory(atPath: imagePath as String, withIntermediateDirectories: true, attributes: nil)
        }
        data?.write(toFile: imagePath.appendingPathComponent(fileName + ".png"), atomically: true)
    }
    
    
    /// 创建一个二维码图片
    /// - Parameter string: 创建二维码的string
   public static func generateQRCode(from string: String) -> UIImage? {
        let data=string.data(using: String.Encoding.ascii)
        if let filter=CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform=CGAffineTransform(scaleX: 6, y: 6)
            
            if let output=filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    
    /// 重新设置图片大小
    /// - Parameters:
    ///   - image: 图片对象
    ///   - reSize: 重设的大小
    public static func getReSizeImage(image : UIImage , reSize : CGSize) -> UIImage{
        UIGraphicsBeginImageContext(CGSize(width : reSize.width, height : reSize.height));
        image.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage!
    }
   
}

