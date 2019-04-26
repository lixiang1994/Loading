//
//  LoadingCustomIndicator.swift
//  Demo
//
//  Created by 李响 on 2019/4/23.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import Loading
import ImageIO

class LoadingCustomIndicator: LoadingIndicator {
    
    private lazy var imageView: UIImageView = {
        $0.backgroundColor = .white
        return $0
    } ( UIImageView() )
    
    required public init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
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
        imageView.startAnimating()
    }
    
    override func stop() {
        imageView.stopAnimating()
    }
}

extension LoadingCustomIndicator {
    
    /// 设置GIF
    ///
    /// - Parameter gif: 图片数据
    func set(gif data: Data) {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return
        }
        // 获取在CGImageSource中图片的个数
        let count = CGImageSourceGetCount(source)
        
        let images: [UIImage] = (0 ..< count).compactMap {
             guard let image = CGImageSourceCreateImageAtIndex(source, $0, nil) else {
                return nil
            }
            return UIImage(cgImage: image)
        }
        let duration = (0 ..< count).reduce(into: 0.0) {
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, $1, nil) as? [CFString : Any] else { return }
            guard let dict = properties[kCGImagePropertyGIFDictionary] as? [CFString : Any] else { return }
            guard let duration = dict[kCGImagePropertyGIFDelayTime] as? Double else { return }
            $0 += duration
        }
        imageView.animationImages = images
        imageView.animationDuration = duration
        imageView.animationRepeatCount = 0
    }
}
