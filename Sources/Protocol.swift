//
//  Protocol.swift
//  ┌─┐      ┌───────┐ ┌───────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ │      │ └─────┐ │ └─────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ └─────┐│ └─────┐ │ └─────┐
//  └───────┘└───────┘ └───────┘
//
//  Created by lee on 2019/4/26.
//  Copyright © 2019年 lee. All rights reserved.
//

import UIKit

public typealias Action = (()->Void)

public protocol Loadingable {
    
    /// 开始
    func start()
    
    /// 停止
    func stop()
}

public protocol LoadingStateable {
    
    /// 失败
    func fail()
    
    /// 设置重载器的事件
    /// - Parameter action: 事件闭包
    func set(reloader action: @escaping Action)
}

public protocol LoadingViewable: Loadingable {
    
    associatedtype Indicator: LoadingIndicator
    
    /// 指示器
    var indicator: Indicator { get }
    
    /// 设置加载视图点击事件
    /// - Parameter handle: 事件闭包
    func action(_ handle: @escaping Action)
}

public protocol LoadingStateViewable: LoadingViewable, LoadingStateable {
    
    associatedtype Reloader = LoadingReloader
    
    /// 重载器
    var reloader: Reloader { get }
}

public protocol LoadingIndicatorable {
    
    /// 相对于加载视图的位置偏移
    var offset: CGPoint { get set }
    
    /// 开始
    func start()
    
    /// 结束
    func stop()
}

public protocol LoadingProgressIndicatorable: LoadingIndicatorable {
    
    /// 进度
    var progress: Double { get set }
}

public protocol LoadingReloadable {
    
    /// 相对于加载视图的位置偏移
    var offset: CGPoint { get set }
    
    /// 设置重载器点击事件
    /// - Parameter handle: 事件闭包
    func action(_ handle: @escaping Action)
}

public protocol SizeConvertible {
    
    var size: CGSize { get }
}

extension Int: SizeConvertible {
    
    public var size: CGSize {
        return CGSize(width: self, height: self)
    }
}

extension Double: SizeConvertible {
    
    public var size: CGSize {
        return CGSize(width: self, height: self)
    }
}

extension CGFloat: SizeConvertible {
   
    public var size: CGSize {
        return CGSize(width: self, height: self)
    }
}

extension CGSize: SizeConvertible {
    
    public var size: CGSize {
        return self
    }
}
