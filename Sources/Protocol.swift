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

public protocol LoadingViewable {
    
    associatedtype Indicator: LoadingIndicator
    
    var indicator: Indicator { get }
    
    func start()
    
    func stop()
    
    func action(_ handle: @escaping Action)
}

public protocol LoadingStateViewable: LoadingViewable {
    
    associatedtype Reloader = LoadingReloader
    
    var reloader: Reloader { get }
    
    func fail()
}

public protocol LoadingIndicatorable {
    
    var offset: CGPoint { get set }
    
    func start()
    
    func stop()
}

public protocol LoadingProgressIndicatorable: LoadingIndicatorable {
    
    var progress: Double { get set }
}

public protocol LoadingReloadable {
    
    var offset: CGPoint { get set }
    
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
