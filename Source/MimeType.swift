//
//  MimeType.swift
//  AlamofireKit
//
//  Created by Rz Rasel on 2021-02-13
//

import Foundation
import UIKit

extension NSURL {
    public func getMimeType() -> String {
        return GetMimeType(ext: self.pathExtension)
    }
}
extension NSString {
    public func getMimeType() -> String {
        return GetMimeType(ext: self.pathExtension)
    }
}
extension String {
    public func getMimeType() -> String {
        return (self as NSString).getMimeType()
    }
}
//#if swift(>=5.3)
//print("Hello, Swift 5.3")
//
//#elseif swift(>=5.2)
//print("Hello, Swift 5.2")
//
//#elseif swift(>=5.1)
//print("Hello, Swift 5.1")
//
//#elseif swift(>=5.0)
//print("Hello, Swift 5.0")
//
//#elseif swift(>=4.2)
//print("Hello, Swift 4.2")
//
//#elseif swift(>=4.1)
//print("Hello, Swift 4.1")
//
//#elseif swift(>=4.0)
//print("Hello, Swift 4.0")
//
//#elseif swift(>=3.2)
//print("Hello, Swift 3.2")
//
//#elseif swift(>=3.0)
//print("Hello, Swift 3.0")
//
//#elseif swift(>=2.2)
//print("Hello, Swift 2.2")
//
//#elseif swift(>=2.1)
//print("Hello, Swift 2.1")
//
//#elseif swift(>=2.0)
//print("Hello, Swift 2.0")
//
//#elseif swift(>=1.2)
//print("Hello, Swift 1.2")
//
//#elseif swift(>=1.1)
//print("Hello, Swift 1.1")
//
//#elseif swift(>=1.0)
//print("Hello, Swift 1.0")
//
//#endif
