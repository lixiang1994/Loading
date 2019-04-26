//
//  LoadingSystemIndicator.swift
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

class LoadingSystemIndicator: LoadingIndicator {
    
    private lazy var indicator: UIActivityIndicatorView = {
        $0.style = .gray
        $0.hidesWhenStopped = true
        return $0
    } ( UIActivityIndicatorView() )
    
    required init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(indicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicator.frame = bounds
    }
    
    public override func start() {
        indicator.startAnimating()
    }
    
    public override func stop() {
        indicator.stopAnimating()
    }
}

extension LoadingSystemIndicator {
    
    func set(style: UIActivityIndicatorView.Style) {
        indicator.style = style
    }
}
