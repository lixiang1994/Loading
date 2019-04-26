//
//  CGSize+Extension.swift
//  Demo
//
//  Created by 李响 on 2019/4/26.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit

extension CGSize {
    
    init(side: CGFloat) {
        self.init(side, side)
    }
    
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
}
