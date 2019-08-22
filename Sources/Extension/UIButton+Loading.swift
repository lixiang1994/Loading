//
//  UIButton+Loading.swift
//  ┌─┐      ┌───────┐ ┌───────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ │      │ └─────┐ │ └─────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ └─────┐│ └─────┐ │ └─────┐
//  └───────┘└───────┘ └───────┘
//
//  Created by lee on 2019/4/23.
//  Copyright © 2019年 lee. All rights reserved.
//

import UIKit

private var tempKey: Void?

extension LoadingWrapper where Base: UIButton {
    
    private struct Info {
        let images: [(Int, UIImage)]
        let colors: [(Int, UIColor)]
        let titles: [(Int, NSAttributedString)]
        let backgrounds: [(Int, UIImage)]
    }
    
    private var states: [UIControl.State] {
        return [
            .normal,
            .highlighted,
            .selected,
            .disabled
        ]
    }
    
    private var temp: Info? {
        get { return objc_getAssociatedObject(base, &tempKey) as? Info }
        set { objc_setAssociatedObject(base, &tempKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    @discardableResult
    public func start(_ indicator: LoadingIndicator = .system(.white),
                      tag: Int = 1994) -> LoadingView {
        let view = Loading.view(indicator)
        start(view, tag: tag)
        return view
    }
    
    public func start(_ view: LoadingView, tag: Int = 1994) {
        stop(tag)
        
        base.layoutIfNeeded()
        base.isUserInteractionEnabled = false
        
        let maskView = UIImageView()
        maskView.tag = tag
        // 遮罩视图同步UIButton背景样式
        maskView.contentMode = .scaleToFill
        maskView.image = base.currentBackgroundImage
        maskView.backgroundColor = base.backgroundColor
        
        // 获取UIButton所有状态内容
        let images = states.enumerated().compactMap {
            (i, state) -> (Int, UIImage)? in
            guard let v = base.image(for: state) else { return nil }
            return (i, v)
        }
        let colors = states.enumerated().compactMap {
            (i, state) -> (Int, UIColor)? in
            guard let v = base.titleColor(for: state) else { return nil }
            return (i, v)
        }
        let titles = states.enumerated().compactMap {
            (i, state) -> (Int, NSAttributedString)? in
            guard let v = base.attributedTitle(for: state) else { return nil }
            return (i, v)
        }
        let backgrounds = states.enumerated().compactMap {
            (i, state) -> (Int, UIImage)? in
            guard let v = base.backgroundImage(for: state) else { return nil }
            return (i, v)
        }
        
        // 临时存储内容
        self.temp = Info(images: images, colors: colors, titles: titles, backgrounds: backgrounds)
        
        // 设置所有内容为透明
        images.filtered(duplication: { $0.1 }).forEach {
            let image = UIImage(color: .clear, size: $0.1.size)
            base.setImage(image, for: states[$0.0])
        }
        colors.filtered(duplication: { $0.1 }).forEach {
            base.setTitleColor(.clear, for: states[$0.0])
        }
        titles.filtered(duplication: { $0.1 }).forEach {
            var title = $0.1
            title = title.reset(foreground: { _ in return .clear })
            title = title.reset(background: { _ in return .clear })
            base.setAttributedTitle(title, for: states[$0.0])
        }
        backgrounds.filtered(duplication: { $0.1 }).forEach {
            let image = UIImage(color: .clear, size: $0.1.size)
            base.setBackgroundImage(image, for: states[$0.0])
        }
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        maskView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = base.bounds
        maskView.frame = base.bounds
        maskView.addSubview(view)
        base.addSubview(maskView)
        base.bringSubviewToFront(maskView)
        
        view.start()
    }
    
    public func stop(_ tag: Int = 1994) {
        defer {
            base.isUserInteractionEnabled = true
        }
        // 移除遮罩视图
        guard let view = base.viewWithTag(tag) else {
            return
        }
        view.removeFromSuperview()
        
        // 恢复原有内容样式
        guard let temp = temp else {
            return
        }
        
        temp.images.filtered(duplication: { $0.1 }).forEach {
            base.setImage($0.1, for: states[$0.0])
        }
        temp.colors.filtered(duplication: { $0.1 }).forEach {
            base.setTitleColor($0.1, for: states[$0.0])
        }
        temp.titles.filtered(duplication: { $0.1 }).forEach {
            base.setAttributedTitle($0.1, for: states[$0.0])
        }
        temp.backgrounds.filtered(duplication: { $0.1 }).forEach {
            base.setBackgroundImage($0.1, for: states[$0.0])
        }
        self.temp = nil
    }
    
    public func fail(_ tag: Int = 1994, reload handle: @escaping ()->Void) {
        print("UIButton 无 fail 状态")
    }
}

fileprivate extension Array {
    
    func filtered<E: Equatable>(duplication closure: (Element) throws -> E) rethrows -> [Element] {
        return try reduce(into: [Element]()) { (result, e) in
            let contains = try result.contains { try closure($0) == closure(e) }
            result += contains ? [] : [e]
        }
    }
}

fileprivate extension UIImage {
    
    convenience init(color: UIColor, size: CGSize) {
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

fileprivate extension NSAttributedString {
    
    func reset(foreground color: (NSRange) -> UIColor) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: self)
        enumerateAttributes(
            in: NSRange(location: 0, length: length),
            options: .longestEffectiveRangeNotRequired
        ) { (attributes, range, stop) in
            var temp = attributes
            if let _ = attributes[.foregroundColor] as? UIColor {
                temp[.foregroundColor] = color(range)
            }
            string.setAttributes(temp, range: range)
        }
        return string
    }
    
    func reset(background color: (NSRange) -> UIColor) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: self)
        enumerateAttributes(
            in: NSRange(location: 0, length: length),
            options: .longestEffectiveRangeNotRequired
        ) { (attributes, range, stop) in
            var temp = attributes
            if let _ = attributes[.backgroundColor] as? UIColor {
                temp[.backgroundColor] = color(range)
            }
            string.setAttributes(temp, range: range)
        }
        return string
    }
}
