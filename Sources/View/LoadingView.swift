//
//  LoadingView.swift
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

open class LoadingView<Indicator: LoadingIndicator>: UIView, LoadingViewable {
    
    public private(set) var indicator: Indicator
    public private(set) var action: Action?
    
    public required init(_ indicator: Indicator) {
        self.indicator = indicator
        super.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(_ indicator: Indicator)")
    }
    override init(frame: CGRect) {
        fatalError("init(_ indicator: Indicator)")
    }
    
    open func start() {
        
    }
    
    open func stop() {
        
    }
    
    open func action(_ handle: @escaping Action) {
        action = handle
    }
}

open class LoadingStateView<Indicator: LoadingIndicator, Reloader: LoadingReloader>: LoadingView<Indicator>, LoadingStateViewable {
    
    public private(set) var reloader: Reloader
    
    public required init(_ indicator: Indicator, _ reloader: Reloader) {
        guard type(of: reloader) != LoadingReloader.self else {
            fatalError("Use LoadingReloader Subclass.")
        }
        self.reloader = reloader
        super.init(indicator)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(_ indicator: Indicator, _ reloader: Reloader)")
    }
    override init(frame: CGRect) {
        fatalError("init(_ indicator: Indicator, _ reloader: Reloader)")
    }
    
    public required init(_ indicator: Indicator) {
        fatalError("init(_ indicator: Indicator, _ reloader: Reloader)")
    }
    
    open func fail() {
        
    }
    
    public func set(reloader action: @escaping Action) {
        reloader.action(action)
    }
}
