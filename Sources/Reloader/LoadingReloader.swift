//
//  LoadingReloader.swift
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

open class LoadingReloader: UIView, LoadingReloadable {

    public typealias Size = SizeConvertible
    
    public var offset: CGPoint {
        didSet { superview?.layoutSubviews() }
    }
    
    public required init(_ size: Size, offset: CGPoint = .zero) {
        self.offset = offset
        super.init(frame: CGRect(origin: .zero, size: size.size))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(_ size: CGSize, offset: CGPoint = .zero)")
    }
    override init(frame: CGRect) {
        fatalError("init(_ size: CGSize, offset: CGPoint = .zero)")
    }
    
    open func action(_ handle: @escaping (()->Void)) {
        
    }
}
