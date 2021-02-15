//
//  MimeType.swift
//  AlamofireKit
//
//  Created by Rz Rasel on 2021-02-13
//

import Foundation
import UIKit
import MobileCoreServices
import AVFoundation

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

extension URL {
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    var containsImage: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeImage)
    }
    var containsAudio: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeAudio)
    }
    var containsVideo: Bool {
        let mimeType = self.mimeType()
        guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeMovie)
    }
    
    //Get current mime type of url w.r.t its url
    var currentMimeType: String {
        
        if self.containsImage{
            return "image/png"
        }else if self.containsAudio{
            return "audio/mp3"
        }else if self.containsVideo{
            return "video/mp4"
        }
        
        return ""
    }
    //https://stackoverflow.com/questions/31243371/path-extension-and-mime-type-of-file-in-swift
}
extension AVFileType {
    /// Fetch and extension for a file from UTI string
    var fileExtension: String {
        if let ext = UTTypeCopyPreferredTagWithClass(self as CFString, kUTTagClassFilenameExtension)?.takeRetainedValue() {
            return ext as String
        }
        return "None"
    }
}
internal var ownIsDebug = false
internal func ownDebugLog(object: Any, message: String, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    if ownIsDebug == false {
        return
    }
    let className = (fileName as NSString).lastPathComponent
    print("DEBUG_LOG_PRINT: " + message + " <\(className)> \(functionName) [\(lineNumber)] | \(object)")
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
