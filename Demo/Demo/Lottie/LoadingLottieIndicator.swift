//
//  LoadingLottieIndicator.swift
//  Demo
//
//  Created by 李响 on 2019/4/24.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import Loading
import Lottie

class LoadingLottieIndicator: UIView {

    private lazy var imageView: AnimationView = {
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
        return $0
    } ( AnimationView() )
    
    public var offset: CGPoint = .zero {
        didSet { superview?.layoutSubviews() }
    }
    
    required public init(_ size: CGSize, offset: CGPoint = .zero) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.offset = offset
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    override init(frame: CGRect) {
        fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(_ size: CGSize, offset: CGPoint)")
    }
}

extension LoadingLottieIndicator {
    
    /// 设置动画
    ///
    /// - Parameter name: 动画资源名称
    func set(animation name: String) {
        imageView.animation = Animation.named(name)
    }
}

extension LoadingLottieIndicator: LoadingIndicatorable {
    
    func start() {
        imageView.play()
    }
    
    func stop() {
        imageView.stop()
    }
}

