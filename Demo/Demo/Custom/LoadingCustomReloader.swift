//
//  LoadingCustomReloader.swift
//  Demo
//
//  Created by 李响 on 2019/4/23.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import Loading

class LoadingCustomReloader: UIView {

    
    private var reload: (()->Void)?
    
    public var offset: CGPoint = .zero {
        didSet { superview?.layoutSubviews() }
    }
    
    required public init(_ size: CGSize, offset: CGPoint = .zero) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.offset = offset
    }
    
    override init(frame: CGRect) {
        fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
}

extension LoadingCustomReloader: LoadingReloadable {
    
    func action(_ handle: @escaping (() -> Void)) {
        reload = handle
    }
}
