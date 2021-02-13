//
//  AlamofireKit.swift
//  AlamofireKit
//
//  Created by Rz Rasel on 2021-01-24.
//
// AlamofireKit Version = '0.1.1'
//  Version = '0.1.0'

import Foundation
import UIKit
import Alamofire

public class AlamofireKit {
    private var method: HTTPMethod = .post
    //    private var headers: [HTTPHeader]!
    private var headers: HTTPHeaders!
    private var headerList: [String: String]!
    private var parameters: Parameters!
    private var httpURL: URLConvertible!
    //
    private var imageQuality: CGFloat!
    private var imageFileName: String!
    private var imageName: String!
    private var uiImage: UIImage!
    private var imageView: UIImageView!
    private var imageData: Data!
    private var mimeType: String!
    //
    
    public init() {
        headers = nil
        headerList = [String: String]()
        headerList.removeAll()
        parameters = [String: String]()
        parameters.removeAll()
    }
    //
    public func headers(headers argHTTPHeaders: HTTPHeaders) -> AlamofireKit {
        headers = argHTTPHeaders
        headers["Content-type"] = "multipart/form-data"
        return self
    }
    public func addParameter(key: String, value: String) -> AlamofireKit {
        parameters[key] = value
        return self
    }
    public func withURL(url argURL: URLConvertible) -> AlamofireKit {
        httpURL = argURL
        return self
    }
    public func method(method argHTTPMethod: HTTPMethod) -> AlamofireKit {
        method = argHTTPMethod
        return self
    }
    //
    public typealias RequestModifier = (inout URLRequest) throws -> Void
    public static func debugPrint(_ convertible: URLConvertible,
                                  method: HTTPMethod = .get,
                                  parameters: Parameters? = nil,
                                  encoding: ParameterEncoding = URLEncoding.default,
                                  headers: HTTPHeaders? = nil,
                                  interceptor: RequestInterceptor? = nil,
                                  requestModifier: RequestModifier? = nil) {
        let request = AF.request(convertible, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        request.responseJSON { response in
            //            debugPrint("DEBUG_LOG_PRINT: response data url \(String(describing: response.request)) line: \(#line)")
            //            debugPrint("DEBUG_LOG_PRINT: status code \(String(describing: response.response?.statusCode)) line: \(#line)")
            print("DEBUG_LOG_PRINT: response data url \(String(describing: response.request)) line: \(#line)")
            print("DEBUG_LOG_PRINT: status code \(String(describing: response.response?.statusCode)) line: \(#line)")
            guard let responseData = response.value else {
                print("DEBUG_LOG_PRINT: data error \(String(describing: response.error)) line: \(#line)")
                return
            }
            print("DEBUG_LOG_PRINT: data success \(responseData) line: \(#line)")
        }
    }
    public typealias Completion<T> = (_ success: Bool, _ data: T) -> Void
    //        public func httpRequest<T>(completion: Completion<T>) {
    //        }
    //        public func httpRequest<T: Decodable>(_ completion: @escaping (HTTPResult<T, HTTPError>) -> Void,
    public static func request<T: Decodable>(_ completion: @escaping (_ success: Bool, _ data: T?, _ error: Error?) -> Void,
                                             dataModel: T.Type,
                                             _ convertible: URLConvertible,
                                             method: HTTPMethod = .get,
                                             parameters: Parameters? = nil,
                                             encoding: ParameterEncoding = URLEncoding.default,
                                             headers: HTTPHeaders? = nil,
                                             interceptor: RequestInterceptor? = nil,
                                             requestModifier: RequestModifier? = nil) {
        let request = AF.request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers)
        request.responseDecodable(of: dataModel.self) { (response) in
            print("DEBUG_LOG_PRINT: request url \(String(describing: response.request)) line: \(#line)")
            print("DEBUG_LOG_PRINT: status code \(String(describing: response.response?.statusCode)) line: \(#line)")
            guard let responseData = response.value else {
                completion(false, nil, response.error)
                return
            }
            completion(true, responseData, nil)
        }
        //        request.responseJSON { response in
        //            debugPrint("DEBUG_LOG_PRINT: request url \(String(describing: response.request)) line: \(#line)")
        //            debugPrint("DEBUG_LOG_PRINT: status code \(String(describing: response.response?.statusCode)) line: \(#line)")
        //            guard let responseData = response.data else {
        //                completion(false, nil, response.error)
        //                return
        //            }
        //            debugPrint("DEBUG_LOG_PRINT: data \(String(describing: responseData)) line: \(#line)")
        //            do {
        //                let modelData = try JSONDecoder().decode(dataModel.self, from: responseData)
        //                debugPrint("DEBUG_LOG_PRINT: data \(String(describing: modelData)) line: \(#line)")
        //                completion(true, modelData, nil)
        //            } catch let jsonErr{
        //                completion(false, nil, jsonErr)
        //            }
        //        }
    }
    public func usageHTTPRequest() {
        //        HTTPHelper.Alamofire.httpRequest({ (success, data, error) in
        //            if success {
        //                print("DATA: \(data)")
        //            } else {
        //                //                print("ERROR: \(error?.localizedDescription)")
        //            }
        //        }, dataModel: ModelApiHomeRoot.self, AppConstant.HTTP.API.HOME_PAGE, method: .get)
    }
}
public enum HTTPResult<Success, Failure> {
    case success(Success)
    case failure(Failure)
}
public enum HTTPError: Error {
    case error(Error)
}
//public enum HTTPResult<T: RawRepresentable> {
//    case success(T)
//    case failure(T)
//}
//public enum Result<Success, Failure> where Failure : Error {
//public enum DataError: Error {
//    case invalid
//}
//public struct ModelTest {
//    var name: String
//}
//
extension AlamofireKit {
    public func withImageName(imageName argImageName: String) -> AlamofireKit {
        imageName = argImageName
        return self
    }
    public func withImageFileName(imageFileName argImageFileName: String) -> AlamofireKit {
        imageFileName = argImageFileName
        return self
    }
    public func withUIImage(uiImageView: UIImageView, imageQuality argImageQuality: CGFloat) -> AlamofireKit {
//        imageView = uiImageView
        uiImage = uiImageView.image
        imageQuality = argImageQuality
        return self
    }
    public func withUIButton(uiButton: UIButton, imageQuality argImageQuality: CGFloat) -> AlamofireKit {
//        var imageFromButton: UIImage = uiButton.image(for: UIControl.State.normal)!
////        imageFromButton = imageFromButton.crop(to: CGSize(width: 1024, height: 1024))
//        imageView = UIImageView(image: imageFromButton)
        uiImage = uiButton.image(for: UIControl.State.normal)!
        imageQuality = argImageQuality
        return self
    }
    //uiImage
    //
    public func uploadImage<T: Decodable>(_ completion: @escaping (_ success: Bool, _ data: T?, _ error: Error?) -> Void, dataModel: T.Type, _ convertible: URLConvertible, cropSize: CGSize) {
//        imageView = UIImageView(image: imageView.image?.crop(cropTo: cropSize))
        uiImage = uiImage.resizeImage(resizeTo: cropSize)
    }
    //START uploadImage
    public func uploadImage<T: Decodable>(_ completion: @escaping (_ success: Bool, _ data: T?, _ error: Error?) -> Void, dataModel: T.Type, _ convertible: URLConvertible) {
        //        headerList["Content-type"] = "multipart/form-data"
        //        for (key, value) in headerList {
        //            headers[key] = value as? String
        //        }
        httpURL = convertible
        print("DEBUG_PRINT: FINAL HEADERS \(String(describing: headers))")
        print("DEBUG_PRINT: FINAL PARAMS \(String(describing: parameters))")
        print("DEBUG_PRINT: FINAL URL \(String(describing: convertible))")
        if imageName == nil {
            print("Error: upload image name is empty")
            return
        }
        if imageFileName == nil {
            print("Error: upload image file name is empty")
            return
        }
        //
        mimeType = imageFileName.getMimeType()
        //        var eImageType = EImageType.byName(name: mimeType)
//        imageData = imageView.image?.jpegData(compressionQuality: imageQuality)
//        imageData = uiImage?.jpegData(compressionQuality: imageQuality)
//        imageData = UIImageJPEGRepresentation(imageData, imageQuality)
        imageData = uiImage!.jpegData(compressionQuality: imageQuality)!
        //
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in self.parameters {
                    if let temp = value as? String {
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if value is Int {
                        multipartFormData.append("(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                            if element is Int {
                                let value = "(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
                multipartFormData.append(self.imageData, withName: self.imageName, fileName: self.imageFileName, mimeType: self.mimeType)
            },
            to: httpURL, method: method, headers: headers)
            //            .validate(statusCode: 200..<300)
            .response {result in
                //                print("DEBUG_PRINT: FINAL - \(result)")
                switch result.result {
                case .success(_):
//                    print("DEBUG_PRINT: Response after upload Img: \(result.data?.jsonString())")
                    if let jsonString = String(data: result.data!, encoding: String.Encoding.utf8) {
                       print("DEBUG_PRINT: response after upload image: \(jsonString)")
                    }
                    do {
                        let data = try JSONDecoder().decode(dataModel.self, from: result.data!)
                        completion(true, data, nil)
                    } catch let error {
                        completion(false, nil, error)
                    }
                case .failure(let error):
                    completion(false, nil, error)
                }
                //                switch resp.result{
                //                case .success(let upload, _, _ ):
                //                    print("Response after upload Img: \(resp.result)")
                //                case .failure(let error):
                //                    print(error)
                //                }
            }
    }
    //END uploadImage
    public enum EImageType: String, CaseIterable, Codable {
        case IMAGE_JPG = "image/jpeg"
        case IMAGE_PNG = "image/png"
        //        case IMAGE_JPEG = "image/jpeg"
        //
        case NONE = "none"
        //
        static func byName(name label: String) -> EImageType {
            return self.allCases.first{ "\($0.rawValue)" == label } ?? .NONE
        }
    }
    //https://github.com/Alamofire/Alamofire/issues/2942
}
