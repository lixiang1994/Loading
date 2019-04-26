//
//  LoadingCustomReloader.swift
//  Demo
//
//  Created by 李响 on 2019/4/23.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import Loading

class LoadingCustomReloader: LoadingReloader {

    private var imageView: UIImageView = {
        $0.image = #imageLiteral(resourceName: "fail")
        $0.backgroundColor = .clear
        return $0
    } ( UIImageView() )
    
    public lazy var button: UIButton = {
        $0.titleLabel?.font = UIFont(name: "GillSans-UltraBold", size: 20)
        $0.setTitle("好难过~戳我重试一下 (˶‾᷄ ⁻̫ ‾᷅˵) ", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    } ( UIButton() )
    private var reload: (()->Void)?
    
    required public init(_ size: Size, offset: CGPoint = .zero) {
        super.init(size, offset: offset)
        
        setup()
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(button)
    }
    private func setupLayout() {
        imageView.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(imageView.snp.width).multipliedBy(552.0/692.0)
        }
        button.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
    }
    
    override func action(_ handle: @escaping (() -> Void)) {
        reload = handle
    }
    
    @objc private func buttonAction(_ sender: UIButton) {
        reload?()
    }
}
