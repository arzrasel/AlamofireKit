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
        return MimeType(ext: self.pathExtension)
    }
}
extension NSString {
    public func getMimeType() -> String {
        return MimeType(ext: self.pathExtension)
    }
}
extension String {
    public func getMimeType() -> String {
        return (self as NSString).mimeType()
    }
}
