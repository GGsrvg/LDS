# LDS

LDS is List Data Source

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

target 'TARGET_NAME' do
    pod 'LDS'
end
```

Replace `TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
```

### Have problems work with UICollectionView

### How use in view controller

ViewDidLoad 
```swift
adapter.observableDataSource = contactsObservableDataSource
```

And deinit
```swift
deinit {
    adapter.observableDataSource = nil
}
```
### How use in cell

When you set content to cell 
```swift
adapter.observableDataSource = contactsObservableDataSource
```

And when cell reusing in `prepareForReuse()` method
```swift
adapter.observableDataSource = nil
```
