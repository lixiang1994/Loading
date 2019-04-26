//
//  LoadingRotateIndicator.swift
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

class LoadingRotateIndicator: LoadingIndicator {
    
    private lazy var view: UIImageView = {
        $0.backgroundColor = .clear
        return $0
    } ( UIImageView() )
    
    required init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = bounds
    }
    
    public override func start() {
        addAnimation()
    }
    
    public override func stop() {
        removeAnimation()
    }
}

extension LoadingRotateIndicator {
    
    /// 设置旋转图片
    ///
    /// - Parameter image: 图片
    func set(image: UIImage) {
        view.image = image
    }
}

extension LoadingRotateIndicator {
    
    private func addAnimation() {
        guard view.layer.animation(forKey: "loading") == nil else {
            return
        }
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.z"
        animation.fromValue = 0
        animation.toValue = 360 * CGFloat(CGFloat.pi / 180)
        animation.duration = 0.9
        animation.repeatCount = HUGE
        animation.isRemovedOnCompletion = false
        view.layer.add(animation, forKey: "loading")
    }
    
    private func removeAnimation() {
        view.layer.removeAllAnimations()
    }
}
