# Loading
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)

An elegant loading view written in swift


## [天朝子民](README_CN.md)

## Features

- [x] Quickly add a loading view.
- [x] No inheritance required.
- [x] Lightweight expansion.
- [x] Good scalability.
- [x] No code intrusion.


## Installation

**CocoaPods - Podfile**

```ruby
source 'https://github.com/lixiang1994/Specs'

pod 'Loading'
```

**Carthage - Cartfile**

```ruby
github "lixiang1994/Loading"
```

## Usage

First make sure to import the framework:

```swift
import Loading
```

Here are some usage examples. All devices are also available as simulators:

### Extension

#### View

```swift
view.loading.start(
    .rotate(#imageLiteral(resourceName: "loading"), at: 30),
    .text("again", font: .systemFont(ofSize: 13), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
)

view.loading.fail() { 
    // reloader click action
}

view.loading.stop()
```

#### Button

```swift
button.loading.start(.system(.white))

button.loading.stop()
```

#### Custom Tag 

```swift
view.loading.start(
    .rotate(#imageLiteral(resourceName: "loading"), at: 30),
    .text("again", font: .systemFont(ofSize: 13), color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)),
    tag: 12345
)

view.loading.fail(12345) { 
    // reloader click action
}

view.loading.stop(12345)
```

### LoadingView

```swift
let loadingView = Loading.view(.system(.gray))
loadingView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
view.addSubview(loadingView)

loadingView.action { 
    // click loading view action
}
loadingView.reloader.action {
    // click reloader action
}

// Start loading
loadingView.start()

// Stop loading
loadingView.stop()

// Failed to load
loadingView.fail()

```

### Indicators

- system 

```swift
view.loading.start(.system(.gray))
```

- rotate

```swift
view.loading.start(.rotate(image))
```

- circle

```swift
view.loading.start(.circle(line: .white, line: 3.0))
```

- images

```swift
view.loading.start(.images([image]))
```

### Reloaders

```swift
// custom text 
LoadingReloader.text("Unable to load, please click again")

// custom image
LoadingReloader.image(image)

// custom view
LoadingReloader.view(view)

```

### Custom 

e.g.

```swift
class LoadingXXXXXXIndicator: LoadingIndicator {
    public override func start() {
        /* ... */
    }
    
    public override func stop() {
        /* ... */
    }
}
```

```swift
class LoadingXXXXXXReloader: LoadingReloader {
    /* ... */
    override func action(_ handle: @escaping (() -> Void)) {
        /* ... */
    }
}
```

```swift
class LoadingXXXXXView: LoadingView {
    
    private var action: (()->Void)?
    
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
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction)
        )
        addGestureRecognizer(tap)
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
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        action?()
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
    
    public override func action(_ handle: @escaping (()->Void)) {
        action = handle
    }
}
```

More examples can refer to the demo.


## Contributing

If you have the need for a specific feature that you want implemented or if you experienced a bug, please open an issue.
If you extended the functionality of Loading yourself and want others to use it too, please submit a pull request.


## License

Loading is under MIT license. See the [LICENSE](LICENSE) file for more info.
