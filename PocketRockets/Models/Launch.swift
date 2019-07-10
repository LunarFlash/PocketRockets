//
//  Launch.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/8/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import Foundation
import SwiftDate
/**
 Model for a SpaceX rocket launch.
 - Remark: SwiftUI prefers models to be reference types, so I am using class instead of struct in the event I want to convert the project to use SwiftUI and Combine later.
 */
final class Launch: Decodable {
    /// Name for this mission.
    var missionName: String = ""
    /// The time of the mission.
    var launchDate: Date?
    /// List of Ids for this mission.
    var missionIds: [String]?
    /// Rocket used on this launch.
    var rocket: Rocket
    
    // MARK: - Computed properties
    
    /// String used to describe launch date
    var launchDateString: String {
        guard let date = launchDate else { return "" }
        let relative = date.toRelative(style: RelativeFormatter.twitterStyle(), locale: Locales.english)
        return String(format: "\(relative) on \(date.toFormat("MMM dd yy"))")
    }
    
    /// Time interval from now until launch time.
    var launchInterval: TimeInterval {
        return launchDate?.timeIntervalSinceNow ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case missionName = "mission_name"
        case launchDate = "launch_date_unix"
        case missionIds = "mission_id"
        case rocket = "rocket"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        missionName = try container.decode(String.self, forKey: .missionName)
        if let launchDateInterval = try container.decodeIfPresent(TimeInterval.self, forKey: .launchDate) {
            launchDate = Date(timeIntervalSince1970: launchDateInterval)
        }
        missionIds = try container.decodeIfPresent([String].self, forKey: .missionIds)
        rocket = try container.decode(Rocket.self, forKey: .rocket)
    }
}


