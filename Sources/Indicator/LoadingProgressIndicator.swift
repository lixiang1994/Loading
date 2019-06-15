//
//  LoadingProgressIndicator.swift
//  ┌─┐      ┌───────┐ ┌───────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ │      │ └─────┐ │ └─────┐
//  │ │      │ ┌─────┘ │ ┌─────┘
//  │ └─────┐│ └─────┐ │ └─────┐
//  └───────┘└───────┘ └───────┘
//
//  Created by lee on 2019/6/15.
//  Copyright © 2019年 lee. All rights reserved.
//

import Foundation

public class LoadingProgressIndicator: LoadingIndicator {
    
    public typealias Format = (Double) -> String
    
    private lazy var backgroundLayer: CAShapeLayer = {
        $0.strokeStart = 0
        $0.strokeEnd = 1
        $0.strokeColor = UIColor.white.cgColor
        $0.fillColor = UIColor.clear.cgColor
        $0.lineWidth = 2
        $0.lineCap = .round
        $0.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        let transform = CGAffineTransform(rotationAngle: -.pi / 2)
        $0.transform = CATransform3DMakeAffineTransform(transform)
        return $0
    } ( CAShapeLayer() )
    
    private lazy var circleLayer: CAShapeLayer = {
        $0.strokeStart = 0
        $0.strokeEnd = 0
        $0.strokeColor = UIColor.black.cgColor
        $0.fillColor = UIColor.clear.cgColor
        $0.lineWidth = 2
        $0.lineCap = .round
        $0.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        let transform = CGAffineTransform(rotationAngle: -.pi / 2)
        $0.transform = CATransform3DMakeAffineTransform(transform)
        return $0
    } ( CAShapeLayer() )
    
    public private(set) lazy var label: UILabel = {
        $0.text = format(0)
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
        $0.textAlignment = .center
        return $0
    } ( UILabel() )
    
    private var format: Format = {
        return "\(Int($0 * 100))%"
    }
    
    required init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .clear
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(circleLayer)
        addSubview(label)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        func setup(_ layer: CAShapeLayer) {
            layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
            layer.bounds = bounds
            
            let center = CGPoint(x: layer.bounds.midX, y: layer.bounds.midY)
            let radius = min(layer.bounds.midX,
                             layer.bounds.midX - layer.lineWidth / 2)
            let path = UIBezierPath(
                arcCenter: center,
                radius: radius,
                startAngle: 0,
                endAngle: CGFloat.pi * 2,
                clockwise: true
            )
            layer.path = path.cgPath
        }
        
        setup(backgroundLayer)
        setup(circleLayer)
        
        label.frame = bounds
    }
}

extension LoadingProgressIndicator {
    
    /// 设置当前进度  0 - 1
    public var progress: Double {
        get {
            return Double(circleLayer.strokeEnd)
        }
        set {
            if (newValue > 1) {
                circleLayer.strokeEnd = 1
                
            } else if (newValue < 0) {
                circleLayer.strokeEnd = 0
                
            } else {
                circleLayer.strokeEnd = CGFloat(newValue)
            }
            
            label.text = format(newValue)
        }
    }
    
    /// 设置格式
    ///
    /// - Parameter format: 格式闭包
    public func set(format: @escaping Format) {
        self.format = format
    }
    
    /// 设置颜色
    ///
    /// - Parameter line: 颜色
    public func set(line color: UIColor) {
        circleLayer.strokeColor = color.cgColor
    }
    
    /// 设置线条宽度
    ///
    /// - Parameter line: 宽度
    public func set(line width: CGFloat) {
        circleLayer.lineWidth = width
        layoutSubviews()
    }
    
    /// 设置背景线条颜色
    ///
    /// - Parameter background: 颜色
    public func set(backgroundLine color: UIColor) {
        backgroundLayer.strokeColor = color.cgColor
    }
    
    /// 设置背景线条宽度
    ///
    /// - Parameter background: 宽度
    public func set(backgroundLine width: CGFloat) {
        backgroundLayer.lineWidth = width
        layoutSubviews()
    }
}
