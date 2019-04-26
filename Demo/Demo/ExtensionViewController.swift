//
//  ExtensionViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/23.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import Loading

class ExtensionViewController: UIViewController {

    private var workItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        workItem?.perform()
        workItem?.cancel()
        let item = DispatchWorkItem {
            sender.loading.stop()
        }
        workItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: item)
        
        switch sender.tag {
        case 0, 2, 3:
            sender.loading.start(.system(.gray))
        
        default:
            sender.loading.start(.system(.white))
        }
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        
        let temp = view.loading.start(.rotate(#imageLiteral(resourceName: "loading"), at: CGSize(side: 30)))
        let reloader = temp.reloader as? LoadingButtonReloader
        reloader?.button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        reloader?.button.titleLabel?.font = .systemFont(ofSize: 13)
        
        // 模拟流程
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            //view.bounds = CGRect(x: 0, y: 0, width: 300, height: 300)
            // 失败
            view.loading.fail {
                // 重新加载
                view.loading.start(.rotate(#imageLiteral(resourceName: "loading"), at: CGSize(side: 30)))
                
                // 模拟流程
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    view.loading.stop()
                }
            }
        }
    }
}

extension UIView {
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
}
