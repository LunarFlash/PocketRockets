//
//  WebAPI.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/8/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import Foundation
import Alamofire

/**
 Object managing networking calls for this app.
 - Remark: Use the shared singleton instance.
 */
class WebAPI {
    /// URL endpoings for  SpaceX's  API
    class Endpoints {
        /// Upcoming launches
        static let upcomingLaunches = URL(string: "https://api.spacexdata.com/v3/launches/upcoming")!
        /// Next launch
        static let nextLaunch = URL(string: "https://api.spacexdata.com/v3/launches/next")!
    }
    
    /// Shared instance of the web API.
    static let shared = WebAPI()
    
    /**
     Fetch a list of upcoming SpaceX rocket launches.
     - parameter completion: Async completion handler for data returned from SpaceX server.
     - parameter launches: Array of rocklet launches.
     - parameter error: Error during the fetching process.
     */
    func fetchUpcomingLaunches(_ completion: @escaping (_ launches: [Launch]?, _ error: Error?) -> Void) {
        Alamofire.request(Endpoints.upcomingLaunches).responseJSON { (response) in
            if let data = response.data {
                do {
                    let launches = try JSONDecoder().decode([Launch].self, from: data)
                    completion(launches, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, response.error)
            }
        }
    }
    
    /**
     Fetch the next rocket launch by SpaceX.
     - parameter completion: Async completion handler for data returned from SpaceX server.
     - parameter launch: Next rocket launch.
     - parameter error: Error during the fetching process.
     */
    func fetchNextLaunch(_ completion: @escaping (_ launch: Launch?, _ error: Error?) -> Void) {
        Alamofire.request(Endpoints.nextLaunch).responseJSON { (response) in
            if let data = response.data {
                do {
                    let nextLaunch = try JSONDecoder().decode(Launch.self, from: data)
                    completion(nextLaunch, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, response.error)
            }
        }
    }
}
