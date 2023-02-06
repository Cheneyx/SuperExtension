//
//  UILabel+Extension.swift
//  SuperExtension
//
//  Created by Cheney on 2023/2/6.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 通过UILabel的systemLayoutSizeFitting去自动计算UILabel的Size
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - preferredMaxLayoutWidth: label的宽度
    ///   - font: 字体大小与字的name会影响计算的高度
    /// - Returns: size 和 label label你爱用不用
    static func getLayoutSizeFitting(text: String,
                                     preferredMaxLayoutWidth: CGFloat,
                                     font: UIFont = UIFont.systemFont(ofSize: 17),
                                     lineBreakMode: NSLineBreakMode = .byWordWrapping) -> (size: CGSize, label: UILabel) {
        let label = UILabel()
        label.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        label.numberOfLines = 0
        label.text = text
        label.font = font
        label.lineBreakMode = lineBreakMode
        label.widthAnchor.constraint(equalToConstant: preferredMaxLayoutWidth).isActive = true
        let size = label.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        label.frame = CGRect(origin: .zero, size: size)
        return (size, label)
    }
    
    /// 设置UILabel的行间距 感觉有text的都通用
    ///
    /// - Parameter space: 行间距
    func setLineSpacing(_ space: CGFloat) {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space

        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
    }
    
    /// 设置UILabel的行高
    /// @Param height: 行高
    func setLineHeight(_ height: CGFloat) {
        guard let text = self.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = height
        paragraphStyle.minimumLineHeight = height
        paragraphStyle.alignment = self.textAlignment
        attributedString.addAttributes([.font: self.font as Any ,
                                        .foregroundColor:self.textColor as Any,
                                        .paragraphStyle: paragraphStyle,
                                        .baselineOffset: (height - self.font.lineHeight)/4
                                       ], range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString
        self.lineBreakMode = .byTruncatingTail
    }
}
