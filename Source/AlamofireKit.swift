//
//  AlamofireKit.swift
//  AlamofireKit
//
//  Created by Rz Rasel on 2021-01-24.
//
// AlamofireKit Version = '0.1.0'
//  Version = '0.1.0'

import Foundation
//import UIKit
import Alamofire

public class AlamofireKit {
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
            debugPrint("DEBUG_LOG_PRINT: response data url \(String(describing: response.request)) line: \(#line)")
            debugPrint("DEBUG_LOG_PRINT: status code \(String(describing: response.response?.statusCode)) line: \(#line)")
            guard let responseData = response.value else {
                debugPrint("DEBUG_LOG_PRINT: data error \(String(describing: response.error)) line: \(#line)")
                return
            }
            debugPrint("DEBUG_LOG_PRINT: data success \(responseData) line: \(#line)")
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
            debugPrint("DEBUG_LOG_PRINT: request url \(String(describing: response.request)) line: \(#line)")
            debugPrint("DEBUG_LOG_PRINT: status code \(String(describing: response.response?.statusCode)) line: \(#line)")
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
