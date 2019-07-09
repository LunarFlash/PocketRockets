//
//  Rocket.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/8/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import Foundation

/**
 Model for a SpaceX rocket.
 - Remark: SwiftUI prefers models to be reference types, so I am using class instead of struct in the event I want to convert the project to use SwiftUI and Combine later.
 */
final class Rocket: Decodable {
    /// Id for the rocket.
    var rocketId: String = ""
    /// Name of the rocket.
    var rocketName: String = ""
    /// Type of rocket.
    var rocketType: String = ""
    /// Core components in a rocket's stage 1.
    var cores = [RocketCore]()
    /// Payloads components in a rocket's stage 2.
    var payloads = [RocketPayload]()
    
    // MARK: - Computed properties
    /// Whether this rocket has any reusable parts for the first or second stage.
    var hasReused: Bool {
        return cores.filter{ $0.reused }.count + payloads.filter{ $0.reused }.count > 0
    }
    
    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case cores = "cores"
        case payloads = "payloads"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rocketId = try container.decode(String.self, forKey: .rocketId)
        rocketName =  try container.decode(String.self, forKey: .rocketName)
        rocketType = try container.decode(String.self, forKey: .rocketType)
        let firstStage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .firstStage)
        cores = try firstStage.decode([RocketCore].self, forKey: .cores)
        let secondStage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .secondStage)
        payloads = try secondStage.decode([RocketPayload].self, forKey: .payloads)
    }
}

/**
 A core in the first stage of a rocket.
 */
final class RocketCore: Decodable, Reusable {
    var reused: Bool
    
    enum CodingKeys: String, CodingKey {
        case reused
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reused = try container.decode(Bool.self, forKey: .reused)
    }
    
}

/*
 A payload in the second stage of a rocket.
 */
final class RocketPayload: Decodable, Reusable {
    var reused: Bool
    
    enum CodingKeys: String, CodingKey {
        case reused
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reused = try container.decode(Bool.self, forKey: .reused)
    }
}
