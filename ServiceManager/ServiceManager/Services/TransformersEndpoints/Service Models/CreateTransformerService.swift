//
//  CreateTransformerService.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Endpoint
class CreateTransformerService: BaseService {
    var path: String { return "transformers" }
}

// MARK: - Request
class CreateTransformerRequest: BaseAuthenticatedRequest {

    private let transformer: Transformer
    
    var method: HTTPMethod { return .post }
    var service: BaseService { return CreateTransformerService() }
    var resultClass: ResponseObject.Type? {
        return CreateTransformerResponseObject.self
    }
    
    var bodyParams: Encodable? {
        return transformer
    }
    
    init(transformer: Transformer) {
        self.transformer = transformer
    }

}

// MARK: - Response
class CreateTransformerResponseObject: Transformer { }
