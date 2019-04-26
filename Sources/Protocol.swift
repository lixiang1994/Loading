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
    
    func start()
    
    func stop()
}

public protocol LoadingReloadable {
    
    var offset: CGPoint { get set }
    
    func action(_ handle: @escaping (()->Void))
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
