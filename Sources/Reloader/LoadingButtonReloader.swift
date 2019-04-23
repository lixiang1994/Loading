//
//  LoadingButtonReloader.swift
//  Loading
//
//  Created by 李响 on 2019/4/22.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

public class LoadingButtonReloader: UIView {
    
    public lazy var button: UIButton = {
        $0.setTitle("加载失败, 点击重试", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    } ( UIButton() )
    private var reload: (()->Void)?
    
    public var offset: CGPoint = .zero {
        didSet { superview?.layoutSubviews() }
    }
    
    required public init(_ size: CGSize, offset: CGPoint = .zero) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.offset = offset
        addSubview(button)
    }
    
    override init(frame: CGRect) {
        fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        reload?()
    }
}

extension LoadingButtonReloader: LoadingReloadable {
    
    public func action(_ handle: @escaping (() -> Void)) {
        reload = handle
    }
}
