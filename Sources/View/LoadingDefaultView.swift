//
//  LoadingDefaultView.swift
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

class LoadingDefaultView: LoadingView {
    
    private var action: (()->Void)?
    
    required init(_ indicator: LoadingIndicator, _ reloader: LoadingReloader) {
        super.init(indicator, reloader)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        isHidden = true
        
        addSubview(indicator)
        addSubview(reloader)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction)
        )
        addGestureRecognizer(tap)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let offset = indicator.offset
            let x = bounds.width * 0.5 + offset.x
            let y = bounds.height * 0.5 + offset.y
            indicator.center = CGPoint(x: x, y: y)
        }
        do {
            let offset = reloader.offset
            let x = bounds.width * 0.5 + offset.x
            let y = bounds.height * 0.5 + offset.y
            reloader.center = CGPoint(x: x, y: y)
        }
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        action?()
    }
    
    public override func start() {
        isHidden = false
        reloader.isHidden = true
        indicator.isHidden = false
        indicator.start()
    }
    
    public override func stop() {
        isHidden = true
        reloader.isHidden = true
        indicator.isHidden = true
        indicator.stop()
    }
    
    public override func fail() {
        isHidden = false
        reloader.isHidden = false
        indicator.isHidden = true
        indicator.stop()
    }
    
    public override func action(_ handle: @escaping (()->Void)) {
        action = handle
    }
}
