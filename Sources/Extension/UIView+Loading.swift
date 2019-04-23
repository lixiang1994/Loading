//
//  UIView+Loading.swift
//  Loading
//
//  Created by 李响 on 2019/4/22.
//  Copyright © 2019 swift. All rights reserved.
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

public extension LoadingWrapper where Base: UIView {
    
    func start(_ type: Loading.Indicator, tag: Int = 1994) {
        start(Loading.view(type), tag: tag)
    }
    
    func start(_ view: LoadingView, tag: Int = 1994) {
        stop(tag)
        
        view.frame = base.bounds
        base.addSubview(view)
        base.bringSubviewToFront(view)
        base.layoutIfNeeded()
        
        view.start()
    }
    
    func fail(_ tag: Int = 1994, reload handle: @escaping ()->Void) {
        guard let view = base.viewWithTag(tag) as? LoadingView else {
            return
        }
        
        base.bringSubviewToFront(view)
        view.reloader.action(handle)
        view.fail()
    }
    
    func stop(_ tag: Int = 1994) {
        guard let view = base.viewWithTag(tag) as? LoadingView else {
            return
        }
        
        view.stop()
        view.removeFromSuperview()
    }
}
