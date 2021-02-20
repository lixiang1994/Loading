//
//  Loading.swift
//  ┌─┐      ┌───────┐ ┌───────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ │      │ └─────┐ │ └─────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ └─────┐│ └─────┐ │ └─────┐
//  └───────┘└───────┘ └───────┘
//
//  Created by lee on 2019/4/22.
//  Copyright © 2019年 lee. All rights reserved.
//

import UIKit

public enum Loading {}

extension Loading {
    
    /// 加载状态
    ///
    /// - loading: 加载中
    /// - success: 成功
    /// - failure: 失败
    public enum State {
        case loading
        case success
        case failure
    }
}

extension LoadingIndicator {
    
    public static func system(_ style: UIActivityIndicatorView.Style,
                              at size: Size = 50) -> LoadingSystemIndicator {
        let temp = LoadingSystemIndicator(size.size)
        temp.set(style: style)
        return temp
    }
    
    public static func rotate(_ image: UIImage,
                              at size: Size = 50) -> LoadingRotateIndicator {
        let temp = LoadingRotateIndicator(size.size)
        temp.set(image: image)
        return temp
    }
    
    public static func circle(line color: UIColor = .white,
                              line width: CGFloat = 2.0,
                              _ duration: TimeInterval = 1.0,
                              _ timingFunction: CAMediaTimingFunction = .init(name: .default),
                              at size: Size = 50) -> LoadingCircleIndicator {
        let temp = LoadingCircleIndicator(size.size)
        temp.set(line: color)
        temp.set(line: width)
        temp.set(duration: duration)
        temp.set(timingFunction: timingFunction)
        return temp
    }
    
    public static func images(_ images: [UIImage],
                              repeat count: Int = 0,
                              _ duration: TimeInterval = 1.0,
                              at size: Size = 50) -> LoadingImagesIndicator {
        let temp = LoadingImagesIndicator(size.size)
        temp.set(images: images)
        temp.set(duration: duration)
        temp.set(repeat: count)
        return temp
    }
    
    public static func progress(line color: UIColor = .black,
                                line width: CGFloat = 2.0,
                                backgroundLine bColor: UIColor = .white,
                                backgroundLine bWidth: CGFloat = 2.0,
                                at size: Size = 50) -> LoadingCircleProgressIndicator {
        let temp = LoadingCircleProgressIndicator(size)
        temp.set(line: color)
        temp.set(line: width)
        temp.set(backgroundLine: bColor)
        temp.set(backgroundLine: bWidth)
        return temp
    }
}

extension LoadingReloader {
    
    public static func text(_ string: String,
                            font: UIFont = .systemFont(ofSize: 17),
                            color: UIColor = .black,
                            at size: Size = CGSize(width: 200, height: 80)) -> LoadingButtonReloader {
        let temp = LoadingButtonReloader(size.size)
        temp.button.setTitle(string, for: .normal)
        temp.button.setTitleColor(color, for: .normal)
        temp.button.titleLabel?.font = font
        return temp
    }
    
    public static func image(_ image: UIImage,
                             at size: Size = CGSize(width: 200, height: 80)) -> LoadingButtonReloader {
        let temp = LoadingButtonReloader(size.size)
        temp.button.setTitle("", for: .normal)
        temp.button.setImage(image, for: .normal)
        return temp
    }
    
    public static func view(_ view: UIView,
                            at size: Size = CGSize(width: 200, height: 80)) -> LoadingSimpleReloader {
        let temp = LoadingSimpleReloader(size.size)
        temp.set(view: view)
        return temp
    }
}

extension Loading {
    
    /// 构建一个有指示器的加载视图
    /// - Parameter indicator: 指示器
    /// - Returns: 加载视图对象
    public static func view<Indicator: LoadingIndicator>(_ indicator: Indicator = LoadingIndicator.system(.white) as! Indicator) -> LoadingView<Indicator> {
        return LoadingDefaultView(indicator)
    }
    
    /// 构建一个有状态的加载视图
    /// - Parameters:
    ///   - indicator: 指示器
    ///   - reloader: 重载器
    /// - Returns: 有状态的加载视图
    public static func view<Indicator: LoadingIndicator, Reloader: LoadingReloader>(_ indicator: Indicator, _ reloader: Reloader) -> LoadingStateView<Indicator, Reloader> {
        return LoadingDefaultStateView(indicator, reloader)
    }
}
