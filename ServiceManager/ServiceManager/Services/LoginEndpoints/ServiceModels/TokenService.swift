//
//  TokenService.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire

class TokenService: BaseService {
    var path: String { return "allspark" }
}

class TokenRequest: BaseRequest {
    
    var method: HTTPMethod { return .get }
    var decoderType: DecoderType { return .string }
    var service: BaseService { return TokenService() }
    var resultClass: ResponseObject.Type? { return nil }
    
    init() {}

}
