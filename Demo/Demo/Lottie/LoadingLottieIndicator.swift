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

class LoadingLottieIndicator: LoadingIndicator {

    private lazy var imageView: AnimationView = {
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
        return $0
    } ( AnimationView() )
    
    required init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
        self.offset = offset
        addSubview(imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    override func start() {
        imageView.play()
    }
    
    override func stop() {
        imageView.stop()
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
