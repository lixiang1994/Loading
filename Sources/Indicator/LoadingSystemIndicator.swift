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

class LoadingSystemIndicator: UIView {
    
    private lazy var indicator: UIActivityIndicatorView = {
        $0.style = .gray
        $0.hidesWhenStopped = true
        return $0
    } ( UIActivityIndicatorView() )
    
    public var offset: CGPoint = .zero {
        didSet { superview?.layoutSubviews() }
    }
    
    required public init(_ size: CGSize, offset: CGPoint = .zero) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.offset = offset
        setup()
    }
    
    override init(frame: CGRect) {
        fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(indicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicator.frame = bounds
    }
}

extension LoadingSystemIndicator {
    
    func set(style: UIActivityIndicatorView.Style) {
        indicator.style = style
    }
}

extension LoadingSystemIndicator: LoadingIndicatorable {
    
    func start() {
        indicator.startAnimating()
    }
    
    func stop() {
        indicator.stopAnimating()
    }
}

