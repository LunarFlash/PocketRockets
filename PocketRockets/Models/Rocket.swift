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
    /// Id for the rocket
    var rocketId: String = ""
    /// Name of the rocket
    var rocketName: String = ""
    /// Type of rocket
    var rocketType: String = ""
    
    // MARK: - Computed properties
    /// Whether this rocket has any reusable parts for the first or second stage.
    var hasReused: Bool {
        return false
    }
    
    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "mission_id"
        case firstStage = "firstStage"
        case secondStage = "secondStage"
        case cores = "cores"
    }
    
    /**
     Decodable enum for accessing whether a rocket has reusable parts in the SpaceX web service.
     */
    enum ReusedKeys: String, CodingKey {
        case reused = "reused"
        case firstStage = "first_stage"
        case cores = "cores"
        case secondStage = "second_stage"
        case payloads = "payloads"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rocketId = try container.decode(String.self, forKey: .rocketId)
        rocketName =  try container.decode(String.self, forKey: .rocketName)
        rocketType = try container.decode(String.self, forKey: .rocketType)
        let firstStage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .firstStage)
        let cores = try firstStage.nestedContainer(keyedBy: CodingKeys.self, forKey: .cores)
        
        
        let secondStage = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .secondStage)
        
    }
    
}


