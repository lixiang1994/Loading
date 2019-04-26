//
//  LoadingImagesIndicator.swift
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

public class LoadingImagesIndicator: LoadingIndicator {

    private lazy var view: UIImageView = {
        $0.backgroundColor = .clear
        return $0
    } ( UIImageView() )
    
    public required init(_ size: Size, offset: CGPoint = .zero) {
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
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = bounds
    }
    
    public override func start() {
        view.startAnimating()
    }
    
    public override func stop() {
        view.stopAnimating()
    }
}

extension LoadingImagesIndicator {
    
    /// 设置序列帧图片集合
    ///
    /// - Parameter image: 图片
    func set(images: [UIImage]) {
        view.animationImages = images
    }
    
    /// 设置序列帧时长
    ///
    /// - Parameter duration: 时长
    func set(duration: TimeInterval) {
        view.animationDuration = duration
    }
    
    /// 设置序列帧重复次数
    ///
    /// - Parameter count: 次数
    func set(repeat count: Int) {
        view.animationRepeatCount = count
    }
}
