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

public class LoadingImagesIndicator: UIView {

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
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        view.frame = bounds
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

extension LoadingImagesIndicator: LoadingIndicatorable {
    
    public func start() {
        view.startAnimating()
    }
    
    public func stop() {
        view.stopAnimating()
    }
}
