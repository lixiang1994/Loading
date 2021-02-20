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
    public func start<Indicator: LoadingIndicator>(_ indicator: Indicator, tag: Int = 1994) -> LoadingView<Indicator> {
        let view = Loading.view(indicator)
        start(view, tag: tag)
        return view
    }

    public func start<Indicator: LoadingIndicator>(_ view: LoadingView<Indicator>, tag: Int = 1994) {
        stop(tag)

        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = base.bounds
        view.tag = tag
        base.addSubview(view)
        base.bringSubviewToFront(view)
        base.layoutIfNeeded()

        view.start()
    }
    
    @discardableResult
    public func start<Indicator: LoadingIndicator, Reloader: LoadingReloader>
    (_ indicator: Indicator, _ reloader: Reloader, tag: Int = 1994) -> LoadingStateView<Indicator, Reloader> {
        let view = Loading.view(indicator, reloader)
        start(view, tag: tag)
        return view
    }
    
    public func start<Indicator: LoadingIndicator, Reloader: LoadingReloader>(_ view: LoadingStateView<Indicator, Reloader>, tag: Int = 1994) {
        stop(tag)
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = base.bounds
        view.tag = tag
        base.addSubview(view)
        base.bringSubviewToFront(view)
        base.layoutIfNeeded()
        
        view.start()
    }
    
    public func fail(_ tag: Int = 1994, reload action: Action? = .none) {
        guard let view = base.viewWithTag(tag) as? UIView & LoadingStateable else {
            return
        }
        
        base.bringSubviewToFront(view)
        
        if let action = action {
            view.set(reloader: action)
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
