//
//  RequestProtocol.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var service: BaseService { get }
    var decoderType: DecoderType { get }
    var pathParams: [String: Any]? { get }
    var bodyParams: Encodable? { get }
    func asUrlRequest() throws -> URLRequest
}

enum DecoderType {
    case JSON
    case string
}

extension RequestProtocol {
    
    var decoderType: DecoderType { return .JSON }
    
    var pathParams: [String: Any]? { return nil }
    var bodyParams: Encodable? { return nil }
    
    /// Returns an URLRequest from the current RequestProtocol
    func asUrlRequest() throws -> URLRequest {
        let url = service.baseUrl.appendingPathComponent(service.path.applyParams(pathParams))
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue
        
        if let bodyParams = bodyParams {
            let body = bodyParams.toJSONData()
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
    
    /// Performs the Request
    /// - Parameter success: if the request is successfull
    /// - Parameter failure: if the request fails
    func sendRequest<T: ResponseObject>(success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let req = try self.asUrlRequest()
                
                switch self.decoderType {
                case .JSON:
                    self.decodeAsJSON(req, success: success, failure: failure)
                case .string:
                    self.decodeAsString(req, success: success, failure: failure)
                }
            } catch {
                DispatchQueue.main.async {
                    failure(ServiceError.invalidRequest)
                }
            }
        }
    }
    
    /// Decode a JSON Response
    /// - Parameter req: The request I'm performing
    /// - Parameter success: if the request is successfull
    /// - Parameter failure: if the request fails
    private func decodeAsJSON<T: ResponseObject>(_ req: URLRequestConvertible, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        self.service.session.request(req).responseJSON { response in
            let responseObject = BaseResponse.init(request: self, response: response)
            guard let decodable = responseObject.decodeJSON(withType: T.self) else {
                DispatchQueue.main.async {
                    failure(ServiceError.invalidResponse)
                }
                return
            }
            DispatchQueue.main.async {
                success(decodable)
            }
        }
    }
    
    /// Decode a String Response
    /// - Parameter req: The request I'm performing
    /// - Parameter success: if the request is successfull
    /// - Parameter failure: if the request fails
    private func decodeAsString<T: ResponseObject>(_ req: URLRequestConvertible, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        self.service.session.request(req).responseString(completionHandler: { response in
            let responseObject = BaseResponse.init(request: self, response: response)
            guard let decodable = responseObject.stringResponse else {
                DispatchQueue.main.async {
                    failure(ServiceError.invalidResponse)
                }
                return
            }
            DispatchQueue.main.async {
                success(T.init(stringValue: decodable))
            }
        })
    }
}
