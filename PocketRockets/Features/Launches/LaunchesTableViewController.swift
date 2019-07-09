//
//  LaunchesTableViewController.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/8/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import UIKit
/**
 Displays a list of SpaceX rocket launches.
 */
class LaunchesTableViewController: UITableViewController {
    
    /// State variable for this tableview representing a list of upcomming rocket launches.
    /// - remark: The property observer triggers refresh of the tableview whenever this state variable changes..
    var upcomingLaunches = [Launch]() {
        didSet { tableView.reloadData() }
    }
    
    /// State variable for the next launch view representing launch data for the next SpaceX launch.
    /// - remark: The property observer triggers refresh of the next launch view.
    var nextLaunch: Launch? {
        didSet { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        fetchData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingLaunches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Note: - I am purposefully force casting here because I want the program to crash in the event that a cell isn't properly dequeued. This is best practice recommended by Apple engineers.
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.reuseIdentifier, for: indexPath) as! LaunchTableViewCell
        return cell
    }
    
}

extension LaunchesTableViewController {
    
    /// Fetch upcomming launches and next launch data from the SpaceX web service.
    private func fetchData() {
        WebAPI.shared.fetchUpcomingLaunches { [weak self] (launches, error) in
            if let error = error {
                print(error)
            }
            guard let launches = launches else { return }
            self?.upcomingLaunches = launches
        }
        WebAPI.shared.fetchNextLaunch { [weak self] launch, error in
            if let error = error {
                print(error)
            } else {
                self?.nextLaunch = launch
            }
        }
    }
}
