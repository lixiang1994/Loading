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

open class LoadingView: UIView, Loadingable {
    
    public private(set) var indicator: LoadingIndicator
    public private(set) var reloader: LoadingReloader
    
    public required init(_ indicator: LoadingIndicator, _ reloader: LoadingReloader) {
        self.indicator = indicator
        self.reloader = reloader
        super.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(_ indicator: Indicator, _ reloader: Reloader)")
    }
    override init(frame: CGRect) {
        fatalError("init(_ indicator: Indicator, _ reloader: Reloader)")
    }

    open func start() {
        
    }
    
    open func stop() {
        
    }
    
    open func fail() {
        
    }
    
    open func action(_ handle: @escaping (() -> Void)) {
        
    }
}
