//
//  LoadingSimpleReloader.swift
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

class LoadingSimpleReloader: LoadingReloader {
    
    private var reload: (()->Void)?
    
    required public init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction)
        )
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach { $0.frame = bounds }
    }
    
    override func action(_ handle: @escaping (() -> Void)) {
        reload = handle
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        reload?()
    }
}

extension LoadingSimpleReloader {
    
    func set(view: UIView) {
        addSubview(view)
    }
}
