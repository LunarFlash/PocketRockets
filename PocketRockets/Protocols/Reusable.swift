//
//  Reusable.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/9/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import Foundation

/**
 A reusable component in a rocket.
 */
protocol Reusable {
    /// Whether this rocket component is reusable
    var reused: Bool { get }
}
