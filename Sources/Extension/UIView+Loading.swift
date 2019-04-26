//
//  UIView+Loading.swift
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

public class LoadingWrapper<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol LoadingCompatible {
    associatedtype LoadingCompatibleType
    var loading: LoadingCompatibleType { get }
}

extension LoadingCompatible {
    
    public var loading: LoadingWrapper<Self> {
        get { return LoadingWrapper(self) }
    }
}

extension UIView: LoadingCompatible { }

extension LoadingWrapper where Base: UIView {
    
    @discardableResult
    public func start(_ indicator: LoadingIndicator = .system(.white),
                      _ reloader: LoadingReloader = .text("加载失败, 点击重试"),
                      tag: Int = 1994) -> LoadingView {
        let view = Loading.view(indicator)
        start(view, tag: tag)
        return view
    }
    
    public func start(_ view: LoadingView, tag: Int = 1994) {
        stop(tag)
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = base.bounds
        view.tag = tag
        base.addSubview(view)
        base.bringSubviewToFront(view)
        base.layoutIfNeeded()
        
        view.start()
    }
    
    public func fail(_ tag: Int = 1994, reload handle: (()->Void)? = .none) {
        guard let view = base.viewWithTag(tag) as? UIView & Loadingable else {
            return
        }
        
        base.bringSubviewToFront(view)
        
        if let handle = handle {
            view.reloader.action(handle)
        }
        view.fail()
    }
    
    public func stop(_ tag: Int = 1994) {
        guard let view = base.viewWithTag(tag) as? UIView & Loadingable else {
            return
        }
        
        view.stop()
        view.removeFromSuperview()
    }
}
