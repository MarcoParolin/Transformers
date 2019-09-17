//
//  BaseResponse.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire

class BaseResponse {
    var request: RequestProtocol
    var response: HTTPURLResponse?
    var httpStatusCode: Int?
    var data: Data?
    var error: Error?
    var stringResponse: String?
    var decodedValue: Any?
    
    required init(request: RequestProtocol, response: DataResponse<Any>? = nil) {
        self.httpStatusCode = response?.response?.statusCode
        self.data = response?.data
        self.request = request
        self.response = response?.response
    }
    
    required init(request: RequestProtocol, response: DataResponse<String>? = nil) {
        self.httpStatusCode = response?.response?.statusCode
        self.data = response?.data
        self.request = request
        self.response = response?.response
        self.stringResponse = response?.value
    }
    
    func decodeJSON<T: ResponseObject>(withType type: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            guard let data = data else {
                self.error = ServiceError.invalidResponse
                return nil
            }
            return try decoder.decode(T.self, from: data)
        } catch let err {
            self.error = err
            return nil
        }
    }
}

public class ResponseObject: Codable {
    var stringValue: String?
    
    required init(stringValue: String) {
        self.stringValue = stringValue
    }
    required init() {}
    required public init(from decoder: Decoder) throws {}
    public func encode(to encoder: Encoder) throws {}
}
