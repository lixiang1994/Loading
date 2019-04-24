//
//  LoadingContainerView.swift
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

class LoadingContainerView<I: LoadingIndicator, R: LoadingReloader>: UIView {
    
    private let indicatorView: I
    private let reloaderView: R
    
    private var action: (()->Void)?
    
    init(_ indicator: I, _ reloader: R) {
        indicatorView = indicator
        reloaderView = reloader
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isHidden = true
        
        addSubview(indicatorView)
        addSubview(reloaderView)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction)
        )
        addGestureRecognizer(tap)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let offset = indicatorView.offset
            let x = bounds.width * 0.5 + offset.x
            let y = bounds.height * 0.5 + offset.y
            indicatorView.center = CGPoint(x: x, y: y)
        }
        do {
            let offset = reloaderView.offset
            let x = bounds.width * 0.5 + offset.x
            let y = bounds.height * 0.5 + offset.y
            reloaderView.center = CGPoint(x: x, y: y)
        }
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        action?()
    }
}

extension LoadingContainerView: Loadingable {
    
    public var indicator: LoadingIndicator {
        return indicatorView
    }
    
    public var reloader: LoadingReloader {
        return reloaderView
    }
    
    public func start() {
        isHidden = false
        reloaderView.isHidden = true
        indicatorView.isHidden = false
        indicatorView.start()
    }
    
    public func stop() {
        isHidden = true
        reloaderView.isHidden = true
        indicatorView.isHidden = true
        indicatorView.stop()
    }
    
    public func fail() {
        isHidden = false
        reloaderView.isHidden = false
        indicatorView.isHidden = true
        indicatorView.stop()
    }
    
    public func action(_ handle: @escaping (()->Void)) {
        action = handle
    }
}
