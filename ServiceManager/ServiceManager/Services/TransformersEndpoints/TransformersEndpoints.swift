//
//  TransformersEndpoints.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

public struct TransformersEndpoints {
    
    public func fetchLocal() -> [Transformer] {
        return CoreDataManager.shared.getTransformers()
    }
    
    public func saveLocal(transformers: [Transformer]) {
        return CoreDataManager.shared.saveTransformers(transformers)
    }

    public func create(transformer: Transformer, completion: @escaping (Transformer) -> Void, failure: @escaping (Error) -> Void) {
        CreateTransformerRequest(transformer: transformer).sendRequest(success: { (response: CreateTransformerResponseObject) in
            completion(response)
        }, failure: failure)
    }

    public func get(id: String?, completion: @escaping ([Transformer]?) -> Void, failure: @escaping (Error) -> Void) {
        GetTransformerRequest(id: id).sendRequest(success: { (response: GetTransformerResponseObject) in
            //If tha hashes of the 2 arrays are equal, means that remote and local data are the same, so i don't need to refresh
            guard response.transformers?.arrayHash != CoreDataManager.shared.getTransformers().arrayHash else {
                completion(nil)
                return
            }
            
            completion(response.transformers)
        }, failure: failure)
    }

    public func edit(transformer: Transformer, completion: @escaping (Transformer) -> Void, failure: @escaping (Error) -> Void) {
        EditTransformerRequest(transformer: transformer).sendRequest(success: { (response: EditTransformerResponseObject) in
            completion(response)
        }, failure: failure)
    }

    public func delete(id: String, completion: @escaping ([Transformer]) -> Void, failure: @escaping (Error) -> Void) {
        DeleteTransformerRequest(id: id).sendRequest(success: { (response: DeleteTransformerResponseObject) in
            completion(response.transformers ?? [])
        }, failure: failure)
    }
}
