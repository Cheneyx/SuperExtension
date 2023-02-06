//
//  UIButton+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

extension UIButton {
    ///设置Button--->>文字居上，图片居下
    ///@param space  间距
    public func setTitleImageVerticalAlignmentWithSpace(_ space: CGFloat) {
        self.verticalAlignmentWithTitleTop(space, isTop: true)
    }
    
    ///设置Button--->>图片居上，文字居下
    ///@param space  间距
    public func setImageTitleVerticalAlignmentWithSpace(_ space: CGFloat) {
        self.verticalAlignmentWithTitleTop(space, isTop: false)
    }
    
    ///设置Button--->>图片居左，文字居右
    ///@param space  间距
    public func setImageTitleHorizontalAlignmentWithSpace(_ space: CGFloat) {
        self.resetEdgeInsets()
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: -space)

    }
    
    ///设置Button--->>图片居右，文字居左
    ///@param space  间距
    public func setTitleImageHorizontalAlignmentWithSpace(_ space: CGFloat) {
        self.resetEdgeInsets()
        let rect = self.contentRect(forBounds: self.bounds)
        let titleSize = self.titleRect(forContentRect: rect).size
        let imageSize = self.imageRect(forContentRect: rect).size
        
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: space)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: 0, right: imageSize.width)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: titleSize.width + space, bottom: 0, right: -titleSize.width - space)

    }
    
    
    fileprivate func resetEdgeInsets(){
        self.imageEdgeInsets = UIEdgeInsets.zero
        self.contentEdgeInsets = UIEdgeInsets.zero
        self.titleEdgeInsets = UIEdgeInsets.zero
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    fileprivate func verticalAlignmentWithTitleTop(_ space: CGFloat , isTop: Bool){
        self.resetEdgeInsets()
        let rect = self.contentRect(forBounds: self.bounds)
        var titleSize = self.titleRect(forContentRect: rect).size
        let imageSize = self.imageRect(forContentRect: rect).size
        
        if let font = self.titleLabel?.font {
            titleSize.width = self.titleLabel?.text?.stringSize(font: font, contarainSize: CGSize(width: rect.width, height: rect.height)).width ?? 0
        }
        
        let halfWidth: CGFloat = (titleSize.width + imageSize.width) / 2
        let halfHight: CGFloat = (titleSize.height + imageSize.height) / 2
        
        let topInset = min(halfHight, titleSize.height)
        let leftInset = (titleSize.width - imageSize.width) > 0 ? (titleSize.width - imageSize.width)/2 : 0
        let bottomInset = (titleSize.height - imageSize.height) > 0 ? (titleSize.height - imageSize.height)/2 : 0
        let rightInset = min(halfWidth, titleSize.width)
        
        if isTop == true {
            self.titleEdgeInsets = UIEdgeInsets(top: -halfHight-space, left: -halfWidth, bottom: halfHight + space, right: halfWidth)
            self.contentEdgeInsets = UIEdgeInsets(top: topInset+space, left: leftInset, bottom: -bottomInset, right: -rightInset)
        }else{
            self.titleEdgeInsets = UIEdgeInsets(top: halfHight+space, left: -halfWidth, bottom: -halfHight - space, right: halfWidth)
            self.contentEdgeInsets = UIEdgeInsets(top: -bottomInset, left: leftInset, bottom: topInset + space, right: -rightInset)
        }
        
    }
}

///快速创建UIButton
extension UIButton {
    public static func CreatButtonWith(title: String,
                                titleColor: UIColor,
                                font: UIFont,
                                disableColor: UIColor? = nil,
                                backImg: UIImage? = nil,
                                disableImg: UIImage? = nil) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = font
        if let color = disableColor {
            btn.setTitleColor(color, for: .disabled)
        }
        if let img = backImg {
            btn.setBackgroundImage(img, for: .normal)
        }
        if let img = disableImg {
            btn.setBackgroundImage(img, for: .disabled)
        }
        return btn
    }
    
    public static func CreatButtonWith(title: String? = nil,
                                titleColor: UIColor? = nil,
                                icon: UIImage? = nil,
                                font: UIFont,
                                selectIcon: UIImage? = nil) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.titleLabel?.font = font
        btn.setImage(icon, for: .normal)
        btn.setImage(selectIcon, for: .normal)
        return btn
    }
}
