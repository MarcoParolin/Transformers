//
//  URL.swift
//  ServiceManager
//
//  Created by Marco Parolin on 13/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

extension String {
    
    /// Add parameters to a String
    /// - Parameter params: url parameters
    func applyParams(_ params: [String: Any]?) -> String {
        var myString = self
        while let paramRange = findParamRange(in: myString) {
            guard let params = params else {
                 myString.replaceSubrange(paramRange, with: "")
                continue
            }
            let paramName = myString[myString.index(after: paramRange.lowerBound)..<paramRange.upperBound]
            if let param = try? findParam(with: "\(paramName)", in: params) {
                myString.replaceSubrange(paramRange, with: param)
            } else {
                continue
            }
        }
        return myString
    }
    
    /// Returns the range of a given string
    private func findParamRange(in string: String) -> Range<String.Index>? {
        if let startRange = string.range(of: "/:") {
            let semicolonIndex = string.index(after: startRange.lowerBound)
            let searchRange: Range<String.Index> = semicolonIndex..<string.endIndex
            if let endRange = string.range(of: "/", options: String.CompareOptions.caseInsensitive, range: searchRange, locale: nil) {
                return semicolonIndex..<endRange.lowerBound
            } else {
                return semicolonIndex..<string.endIndex
            }
        }
        return nil
    }
    
    /// Replaces the keys with the given parameters
    /// - Parameter name: The key of the parameter
    /// - Parameter parameters: parameter dictionary
    private func findParam(with name: String, in parameters: [String: Any]?) throws -> String {
        guard let parameters = parameters else {
            throw ServiceError.paramNotFound
        }
        if let param = parameters[name] {
            return "\(param)"
        } else {
            throw ServiceError.paramNotFound
        }
    }
}
