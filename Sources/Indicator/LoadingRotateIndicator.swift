//
//  LoadingRotateIndicator.swift
//  Loading
//
//  Created by 李响 on 2019/4/22.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

class LoadingRotateIndicator: UIView {
    
    private lazy var view: UIImageView = {
        $0.backgroundColor = .clear
        return $0
    } ( UIImageView() )
    
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
        
        addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = bounds
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
extension LoadingRotateIndicator: LoadingIndicatorable {
    
    func start() {
        addAnimation()
    }
    
    func stop() {
        removeAnimation()
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
