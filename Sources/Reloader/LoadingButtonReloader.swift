//
//  LoadingButtonReloader.swift
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

public class LoadingButtonReloader: LoadingReloader {
    
    lazy var button: UIButton = {
        $0.setTitle("加载失败, 点击重试", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    } ( UIButton() )
    
    required public init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = bounds
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        action?()
    }
}
