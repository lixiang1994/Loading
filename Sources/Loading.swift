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

public protocol Loadingable {
    
    var indicator: LoadingIndicator { get }
    
    var reloader: LoadingReloader { get }
    
    func start()
    
    func stop()
    
    func fail()
    
    func action(_ handle: @escaping (()->Void))
}

public protocol LoadingIndicatorable {
    
    var offset: CGPoint { get set }
    
    init(_ size: CGSize, offset: CGPoint)
    
    func start()
    
    func stop()
}

public protocol LoadingReloadable {
    
    var offset: CGPoint { get set }
    
    init(_ size: CGSize, offset: CGPoint)
    
    func action(_ handle: @escaping (()->Void))
}

public typealias LoadingView = (UIView & Loadingable)
public typealias LoadingIndicator = (UIView & LoadingIndicatorable)
public typealias LoadingReloader = (UIView & LoadingReloadable)

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
    
    /// 指示器类型
    ///
    /// - system: 系统菊花
    /// - rotate: 旋转图片
    /// - circle: 圆形环形
    /// - images: 序列帧
    public enum Indicator {
        case system(UIActivityIndicatorView.Style)
        case rotate(UIImage, size: CGFloat)
        case circle(UIColor, duration: TimeInterval, lineWidth: CGFloat)
        case images([UIImage], duration: TimeInterval, repeat: Int)
    }
}

extension Loading {
    
    public static func view(_ type: Indicator) -> LoadingView {
        let reloader = LoadingButtonReloader(CGSize(width: 200, height: 80))
        return view(type, reloader)
    }
    
    public static func view<R: LoadingReloader>(_ type: Indicator, _ reloader: R) -> LoadingView {
        
        switch type {
        case let .system(style):
            let temp = LoadingSystemIndicator(CGSize(width: 50, height: 50))
            temp.set(style: style)
            return LoadingContainerView(temp, reloader)
            
        case let .rotate(image, size):
            let temp = LoadingRotateIndicator(CGSize(width: size, height: size))
            temp.set(image: image)
            return LoadingContainerView(temp, reloader)
            
        case let .circle(color, duration, line):
            let temp = LoadingCircleIndicator(CGSize(width: 50, height: 50))
            temp.set(color: color)
            temp.set(line: line)
            temp.set(duration: duration)
            return LoadingContainerView(temp, reloader)
            
        case let .images(images, duration, count):
            let size = images.first?.size ?? CGSize(width: 50, height: 50)
            let temp = LoadingImagesIndicator(size)
            temp.set(images: images)
            temp.set(duration: duration)
            temp.set(repeat: count)
            return LoadingContainerView(temp, reloader)
        }
    }
    
    public static func view<I: LoadingIndicator>(_ indicator: I) -> LoadingView {
        let reloader = LoadingButtonReloader(CGSize(width: 200, height: 80))
        return LoadingContainerView(indicator, reloader)
    }
    
    public static func view<I: LoadingIndicator, R: LoadingReloader>(_ indicator: I, _ reloader: R) -> LoadingView {
        return LoadingContainerView(indicator, reloader)
    }
}
