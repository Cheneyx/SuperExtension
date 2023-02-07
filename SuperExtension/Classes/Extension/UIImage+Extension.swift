//
//  UIImage+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
//图像渐变方向的枚举
public enum GradientDirection {
    /// 水平从左到右
    case horizontal
    /// 垂直从上到下
    case vertical
    /// 左上到右下
    case leftOblique
    /// 右上到左下
    case rightOblique
    /// 自定义
    case other(CGPoint, CGPoint)
    
    func point(size: CGSize) -> (CGPoint, CGPoint) {
        switch self {
        case .horizontal:
            return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: 0))
        case .vertical:
            return (CGPoint(x: 0, y: 0), CGPoint(x: 0, y: size.height))
        case .leftOblique:
            return (CGPoint(x: 0, y: 0), CGPoint(x: size.width, y: size.height))
        case .rightOblique:
            return (CGPoint(x: size.width, y: 0), CGPoint(x: 0, y: size.height))
        case .other(let stat, let end):
            return (stat, end)
        }
    }
}

extension UIImage {
    /// 截屏
    public static var screenShot: UIImage? {

        //  获取主window
        guard let window = UIApplication.shared.keyWindow else {
            return nil
        }
        
        // 开启图片上下文 opaque如果改成false的话,会增加截图的大小
        UIGraphicsBeginImageContextWithOptions(window.size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
    
        //  把window内容渲染到图片上下文中 -Hierarchy层次的意思,性能要比drawRect要高
        window.drawHierarchy(in: window.bounds, afterScreenUpdates: false)
        
        //  从上下文中获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        return image
    }
    
    public func imageWaterMark(text: String? = nil, textPoint: CGPoint = .zero, attribute: Dictionary<NSAttributedString.Key, Any>? = nil, image: UIImage? = nil, imagePoint: CGPoint = .zero, alpha: CGFloat = 1) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        
        draw(at: CGPoint(x: 0, y: 0), blendMode: .normal, alpha: 1)
        
        if let img = image {
            img.draw(at: imagePoint, blendMode: .normal, alpha: alpha)
        }
        
        
        if let str = text {
            str.draw(at: textPoint, withAttributes: attribute)
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage
    }
    
     
    // MARK: 生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]
    /// 生成带圆角渐变色的图片 [UIColor, UIColor, UIColor]
    /// - Parameters:
    ///   - colors: UIColor 数组
    ///   - size: 图片大小
    ///   - radius: 圆角
    ///   - locations: locations 数组
    ///   - direction: 渐变的方向
    /// - Returns: 带圆角的渐变的图片
    public static func gradient(_ colors: [UIColor],
                         size: CGSize = CGSize(width: 10, height: 10),
                         radius: CGFloat = 0,
                         locations:[CGFloat]? = nil,
                         direction: GradientDirection = .horizontal) -> UIImage? {
        if colors.count == 0 || colors.count == 1 { return nil }
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: radius)
        path.addClip()
        context?.addPath(path.cgPath)
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map{$0.cgColor} as CFArray, locations: locations?.map { CGFloat($0) }) else { return nil
        }
        let directionPoint = direction.point(size: size)
        context?.drawLinearGradient(gradient, start: directionPoint.0, end: directionPoint.1, options: .drawsBeforeStartLocation)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        
        defer {
            UIGraphicsEndImageContext()
        }
        
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        
        self.init(cgImage: aCgImage)
    }
}
