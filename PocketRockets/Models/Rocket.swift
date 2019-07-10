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
final class Rocket: Decodable, CustomStringConvertible{
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
    /// Number of reused components from the stage 1 cores and stage 2 payloads of the rocket
    var reusedCount: Int {
        let coreReusableCount = cores.compactMap{$0.reused}.count
        let payloadReusableCount = payloads.compactMap{$0.reused}.count
        return coreReusableCount + payloadReusableCount
    }
    /// Whether this rocket has any reusable parts for the first or second stage.
    var hasReused: Bool {
        return reusedCount > 0
    }
    
    var description: String {
        return "rocketId: \(rocketId)\nrocketName: \(rocketName)\nrocketType: \(rocketType)\nreusedCount: \(reusedCount)"
    }
    
    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case cores
        case payloads
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
    var reused: Bool?
    /// Serial of the core component,
    var serial: String?
    
    enum CodingKeys: String, CodingKey {
        case reused
        case serial
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reused = try container.decodeIfPresent(Bool.self, forKey: .reused)
        serial = try container.decodeIfPresent(String.self, forKey: .serial)
    }
}

/*
 A payload in the second stage of a rocket.
 */
final class RocketPayload: Decodable, Reusable {
    var reused: Bool?
    /// Id for the payload
    var payloadId: String?
    
    enum CodingKeys: String, CodingKey {
        case reused
        case payloadId = "payload_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reused = try container.decodeIfPresent(Bool.self, forKey: .reused)
        payloadId = try container.decodeIfPresent(String.self, forKey: .payloadId)
    }
}
