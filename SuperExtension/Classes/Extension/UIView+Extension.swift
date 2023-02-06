//
//  UIView+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

extension UIView {
    
    ///  x坐标
    public var x: CGFloat {
        get {
            return frame.origin.x
        } set {
            frame.origin.x = newValue
        }
    }
    
    ///  y坐标
    public var y: CGFloat {
        get {
            return frame.origin.y
        } set {
            frame.origin.y = newValue
        }
    }
    
    ///  宽度
    public var width: CGFloat {
        get {
            return frame.size.width
        } set {
            frame.size.width = newValue
        }
    }
    
    ///  高度
    public var height: CGFloat {
        get {
            return frame.size.height
        } set {
            frame.size.height = newValue
        }
    }
    
    ///  中心x
    public var centerX: CGFloat {
    
        get {
            return center.x
        } set {
        
            center.x = newValue
        }
    }
    
    ///  中心y
    public var centerY: CGFloat {
        
        get {
            return center.y
        } set {
            
            center.y = newValue
        }
    }
    
    ///  size
    public var size: CGSize {
        get {
            return frame.size
        } set {
            frame.size = newValue
        }
    }
    
    ///  left
    public var left: CGFloat {
        get {
            return self.x
        } set {
            self.x = newValue
        }
    }
    
    ///  right
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set {
            self.x = newValue - self.width
        }
    }
    
    ///  top
    public var top: CGFloat {
        get {
            return self.y
        } set {
            self.y = newValue
        }
    }
    
    ///  bottom
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set {
            self.y = newValue - self.height
        }
    }
    
    /// origin
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame = CGRect(origin: newValue, size: self.frame.size)
        }
    }
}

extension UIView {
    
    /// 所在window的frame
    public var windowFrame: CGRect? {
        return superview?.convert(frame, to: nil)
    }
    
    /// 倒角
    ///
    /// - Parameter radius: 倒角的半径
    /// - Returns: 对象自己
    @discardableResult
    public func makeRoundedCorners(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }
    
    /// 倒圆角
    ///
    /// - Returns: 对象自己
    @discardableResult
    public func makeCycleCorner() -> Self {
        // 倒短边
        let diameter = frame.size.width <= frame.size.height ? frame.size.width : frame.size.height
        return makeRoundedCorners(diameter / 2)
    }
    
    /// 使用蒙板进行局部倒角
    ///
    /// - Parameters:
    ///   - size: 这个就是view本身的frame.size,由于可能使用SnapKit布局,往往拿不到这个参数,所以就带了这个参数
    ///   - cornerRadii: 倒角的弧度 可以认为是layer.cornerRadius中的cornerRadius,不过是CGSize(width: cornerRadius, height: cornerRadius)
    ///   - corner: 倒角的位置 数组表示topLeft topRight bottomLeft bottomRight allCorners 默认是倒所有角
    @discardableResult
    public func makeCorners(size: CGSize? = nil, cornerRadii: CGSize, corner: UIRectCorner = [.allCorners]) -> Self {
        let unwrapedSize = size ?? bounds.size
        let rect = CGRect(origin: CGPoint.zero, size: unwrapedSize)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: cornerRadii)
        let masklayer = CAShapeLayer()
        masklayer.frame = bounds
        masklayer.path = path.cgPath
        layer.mask = masklayer
        return self
    }
    
    /// 为view添加图片
    ///
    /// - Parameter image: 图片
    /// - Returns: 对象自己
    @discardableResult
    public func setImage(image: UIImage?) -> Self {
        layer.contents = image?.cgImage
        return self
    }
    
    /// 为view添加模糊效果
    ///
    /// - Parameter style: UIBlurEffect.Style
    /// - Returns: 对象自己
    @discardableResult
    public func applyEffect(style: UIBlurEffect.Style) -> Self {
        for subview in subviews where subview is UIVisualEffectView {
            subview.removeFromSuperview()
        }
        
        let blurEffect = UIBlurEffect(style: style)
        let visualView = UIVisualEffectView(effect: blurEffect)
        visualView.frame = bounds
        insertSubview(visualView, at: 0)
        return self
    }
    
    /// 为view添加Shadow效果
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - shadowOffset: 阴影偏移
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影倒角
    /// - Returns: 对象自己
    @discardableResult
    public func applyShadow(color: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) -> Self {
        layer.masksToBounds = true
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        return self
    }
    
    /// 边线的位置 上左下右全
    public struct BorderLocation: OptionSet {
        
        public typealias RawValue = Int
        
        public var rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        static let top = BorderLocation(rawValue: 1 << 0)
        
        static let left = BorderLocation(rawValue: 1 << 1)
        
        static let bottom = BorderLocation(rawValue: 1 << 2)
        
        static let right = BorderLocation(rawValue: 1 << 3)
        
        static let all = [top, left, bottom, right]
    }
    
    /// 为view添加边线
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - borderWidth: 边线的颜色
    ///   - location: 边线的位置
    /// - Returns: 对象自己
    @discardableResult
    public func applyBorder(color: UIColor, borderWidth: CGFloat, location: BorderLocation) -> Self {
        switch location {
        case .top:
            let layer = CALayer()
            layer.backgroundColor = color.cgColor
            layer.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)
        case .left:
            let layer = CALayer()
            layer.backgroundColor = color.cgColor
            layer.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.height)
        case .bottom:
            let layer = CALayer()
            layer.backgroundColor = color.cgColor
            layer.frame = CGRect(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth)
        case .right:
            let layer = CALayer()
            layer.backgroundColor = color.cgColor
            layer.frame = CGRect(x: frame.width - borderWidth, y: 0, width: borderWidth, height: frame.height)
        default:
            let _ = BorderLocation.all.map { applyBorder(color: color, borderWidth: borderWidth, location: $0) }
        }
        return self
    }
}

extension UIView {
    
    /// 截屏 透明 清晰度是UIScreen.main.scale
    public var captureImage: UIImage? {
        
        // 参数①：截屏区域  参数②：是否透明  参数③：清晰度
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    /// 截屏 不透明 清晰度是0
    public var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
