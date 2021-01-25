# AlamofireKit

[![CI Status](https://img.shields.io/travis/Rashed/AlamofireKit.svg?style=flat)](https://travis-ci.org/Rashed/AlamofireKit)
[![Version](https://img.shields.io/cocoapods/v/AlamofireKit.svg?style=flat)](https://cocoapods.org/pods/AlamofireKit)
[![License](https://img.shields.io/cocoapods/l/AlamofireKit.svg?style=flat)](https://cocoapods.org/pods/AlamofireKit)
[![Platform](https://img.shields.io/cocoapods/p/AlamofireKit.svg?style=flat)](https://cocoapods.org/pods/AlamofireKit)
[![GitHub release](https://img.shields.io/github/tag/arzrasel/AlamofireKit.svg)](https://github.com/arzrasel/AlamofireKit/releases)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11
- Swift 5
- Xcode 12

## Installation

AlamofireKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AlamofireKit'
```

## HTTP Request

```swift
AlamofireKit.request({ (success, data, error) in
    if success {
        guard let data = data else {
            return
        }
        self.apiModel = data
    } else {
        print("ERROR: \(String(describing: error))")
    }
}, dataModel: ApiModel.self, "https://api-url", method: .get, parameters: parameters)
```

## Author

Rz Rasel

## License

AlamofireKit is available under the MIT license. See the LICENSE file for more info.
