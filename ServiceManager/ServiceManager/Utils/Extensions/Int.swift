//
//  Int.swift
//  ServiceManager
//
//  Created by Marco Parolin on 12/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import Foundation

public extension Optional where Wrapped == Int {
    // I did this mainly because writing ?? over and over somethimes look confusing
    /// Return a non optional Int from an optional Int
    var orZero: Int {
        return self ?? 0
    }
}
