//
//  ViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/22.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import Loading
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    private var list: [String] = [
        "系统菊花指示器",
        "旋转图片指示器",
        "圆形环形指示器",
        "序列帧指示器",
        "自定义指示器",
        "Lottie指示器"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        
        cancelButtonItem.isEnabled = false
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        let views: [LoadingView] = view.subviews.compactMap {
            $0 as? LoadingView
        }
        views.forEach {
            $0.stop()
            $0.removeFromSuperview()
        }
        
        sender.isEnabled = false
    }
}

extension ViewController {
    
    private func simulation(loading view: LoadingView) {
        
        cancelButtonItem.isEnabled = true
        
        view.action {
            // 加载视图点击事件
        }
        view.reloader.action {
            view.start()
            
            // 模拟流程
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                view.stop()
                view.removeFromSuperview()
            }
        }
        
        // 模拟流程
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            view.fail()
        }
        
        view.start()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let loadingView = Loading.view(.system(.gray))
            loadingView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            view.addSubview(loadingView)
            
            // Frame
            loadingView.frame = view.bounds
            
            // 模拟加载流程
            simulation(loading: loadingView)
            
        case 1:
            let loadingView = Loading.view(.rotate(#imageLiteral(resourceName: "loading"), size: 50))
            loadingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4460616438)
            view.addSubview(loadingView)
            let reloader = loadingView.reloader as? LoadingButtonReloader
            reloader?.button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            
            // SnapKit
            loadingView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            view.layoutIfNeeded()
            
            // 模拟加载流程
            simulation(loading: loadingView)
            
        case 2:
            let loadingView = Loading.view(.circle(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), duration: 1, lineWidth: 4))
            loadingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4460616438)
            view.addSubview(loadingView)
            let reloader = loadingView.reloader as? LoadingButtonReloader
            reloader?.button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            
            // Frame
            loadingView.frame = view.bounds
            
            // 模拟加载流程
            simulation(loading: loadingView)
            
        case 3:
            let images: [UIImage] = (0...15).compactMap {
                let name = String(format: "loading%02d@2x", $0)
                guard
                    let url = Bundle.main.url(forResource: name, withExtension: "png"),
                    let data = try? Data(contentsOf: url) else {
                    return nil
                }
                return UIImage(data: data, scale: 2.0)
            }
            
            let loadingView = Loading.view(.images(images, duration: 0.8, repeat: 0))
            loadingView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            view.addSubview(loadingView)
            
            // SnapKit
            loadingView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            view.layoutIfNeeded()
            
            // 模拟加载流程
            simulation(loading: loadingView)
            
        case 4:
            guard
                let url = Bundle.main.url(forResource: "miao", withExtension: "gif"),
                let data = try? Data(contentsOf: url) else {
                return
            }
            
            let indicator = LoadingCustomIndicator(CGSize(width: 300, height: 150))
            indicator.set(gif: data)
            let reloader = LoadingCustomReloader(CGSize(width: 300, height: 240))
            let loadingView = Loading.view(indicator, reloader)
            loadingView.backgroundColor = #colorLiteral(red: 0.4031304717, green: 0.8062090278, blue: 0.9992662072, alpha: 1)
            view.addSubview(loadingView)
            
            // SnapKit
            loadingView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            view.layoutIfNeeded()
            
            // 模拟加载流程
            simulation(loading: loadingView)
            
            // 模拟动态更改偏移位置
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                indicator.offset = CGPoint(x: 0, y: -50)
            }
            
        case 5:
            let indicator = LoadingLottieIndicator(CGSize(width: 300, height: 300))
            indicator.set(animation: "PinJump")
            let loadingView = Loading.view(indicator)
            loadingView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            view.addSubview(loadingView)
            
            // SnapKit
            loadingView.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            view.layoutIfNeeded()
            
            // 模拟加载流程
            simulation(loading: loadingView)
            
        default:
            break
        }
    }
}

