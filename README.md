# LDS

LDS is List Data Source

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

```ruby
# Podfile
use_frameworks!

target 'TARGET_NAME' do
    pod 'LDS', '~> 1.0'
end
```

Replace `TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
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
