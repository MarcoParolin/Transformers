//
//  Array.swift
//  ServiceManager
//
//  Created by Marco Parolin on 14/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    /// Return an hash that represent the whole array
    var arrayHash: Int {
        let hashSum = self.reduce("") { (accumulator, param) -> String in
            return "\(accumulator.hashValue)" + "\(param.hashValue)"
        }
        return hashSum.hashValue
    }
}
