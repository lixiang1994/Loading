# Loading
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

一个基于Swift优雅的加载视图

## 特性

- [x] 快速添加加载视图.
- [x] 不需要继承.
- [x] 轻量级扩展.
- [x] 良好的可扩展性.
- [x] 无代码入侵.


## 安装

**CocoaPods - Podfile**

```ruby
source 'https://github.com/lixiang1994/Specs'

pod 'Loading'
```

**Carthage - Cartfile**

```ruby
github "lixiang1994/Loading"
```

## 使用

首先导入framework:

```swift
import Loading
```

以下是一些使用示例. 可以在所有设备中使用也可用作模拟器:

### 扩展

#### 视图扩展

```swift
view.loading.start(
    .rotate(#imageLiteral(resourceName: "loading"), at: 30), // 设置指示器
    .text("again", font: .systemFont(ofSize: 13), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) // 设置重载器
)

view.loading.fail() { 
    // 重载点击事件
}

view.loading.stop()
```

#### 按钮扩展

```swift
button.loading.start(.system(.white))

button.loading.stop()
```

#### 自定义 Tag 

```swift
view.loading.start(
    .rotate(#imageLiteral(resourceName: "loading"), at: 30),
    .text("again", font: .systemFont(ofSize: 13), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
    tag: 12345
)

view.loading.fail(12345) { 
    // 重载点击事件
}

view.loading.stop(12345)
```

### 加载视图

```swift
let loadingView = Loading.view(.system(.gray))
loadingView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
view.addSubview(loadingView)

loadingView.action { 
    // 点击加载视图事件
}
loadingView.reloader.action {
    // 点击重载事件
}

// 开始加载 (默认行为: 显示加载视图 启动指示器)
loadingView.start()

// 停止加载 (默认行为: 隐藏加载视图 停止指示器)
loadingView.stop()

// 加载失败 (默认行为: 显示重新加载 停止指示器)
loadingView.fail()

```

### 指示器

- 系统指示器 (菊花) 

```swift
view.loading.start(.system(.gray))
```

- 旋转图片指示器

```swift
view.loading.start(.rotate(image))
```

- 圆环指示器

```swift
view.loading.start(.circle(line: .white, line: 3.0))
```

- 序列帧指示器

```swift
view.loading.start(.images([image]))
```

### 重载器

```swift
// 自定义文本
LoadingReloader.text("加载失败啦, 请点击重试")

// 自定义图片
LoadingReloader.image(image)

// 自定义视图
LoadingReloader.view(view)

```

### 自定义 

示例:

```swift
// 自定义指示器 继承自LoadingIndicator 并重写相关方法
class LoadingXXXXXXIndicator: LoadingIndicator {
    /* ... */
    
    public override func start() {
        /* ... */
    }
    
    public override func stop() {
        /* ... */
    }
}
```

```swift
自定义重载器 继承自LoadingReloader 并重写相关方法
class LoadingXXXXXXReloader: LoadingReloader {
    /* ... */
    
    @objc 
    private func buttonAction(_ sender: UIButton) {
        // 调用action闭包 触发重试事件回调
        action?()
    }
}
```

```swift
// 自定义加载视图 继承自LoadingStateView 并重写相关方法和逻辑, 以下示例为默认加载视图的实现逻辑
class LoadingXXXXXStateView<Indicator: LoadingIndicator, Reloader: LoadingReloader>: LoadingStateView<Indicator, Reloader> {
    
    required init(_ indicator: LoadingIndicator, _ reloader: LoadingReloader) {
        super.init(indicator, reloader)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        isHidden = true
        
        addSubview(indicator)
        addSubview(reloader)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        do {
            let offset = indicator.offset
            let x = bounds.width * 0.5 + offset.x
            let y = bounds.height * 0.5 + offset.y
            indicator.center = CGPoint(x: x, y: y)
        }
        do {
            let offset = reloader.offset
            let x = bounds.width * 0.5 + offset.x
            let y = bounds.height * 0.5 + offset.y
            reloader.center = CGPoint(x: x, y: y)
        }
    }
    
    public override func start() {
        isHidden = false
        reloader.isHidden = true
        indicator.isHidden = false
        indicator.start()
    }
    
    public override func stop() {
        isHidden = true
        reloader.isHidden = true
        indicator.isHidden = true
        indicator.stop()
    }
    
    public override func fail() {
        isHidden = false
        reloader.isHidden = false
        indicator.isHidden = true
        indicator.stop()
    }
}
```

更多示例可以参考Demo。


## 贡献

如果你需要实现特定功能或遇到错误，请打开issue。 如果你自己扩展了Loading的功能并希望其他人也使用它，请提交拉取请求。


## 许可协议

Loading 使用 MIT 协议。 有关更多信息，请参阅 [LICENSE](LICENSE) 文件。
