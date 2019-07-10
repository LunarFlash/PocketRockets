//
//  LaunchesTableViewCell.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/9/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import UIKit

/**
 Table view cell used to display information about a rocket launch.
 */
class LaunchTableViewCell: UITableViewCell {
    /// Reuse identifier
    static let reuseIdentifier = "LaunchCell"
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowToCard()
        setCornerRadius(radius: 10)
    }
}

extension LaunchTableViewCell {
    /**
     Update the UI using a Launch object
     - parameter launch: Data model for a launch used to populate this view.
     */
    func updateUI(_ launch: Launch) {
        
    }
    
    
    /// Perform initial setup duties
    private func setupUI() {
        addShadowToCard()
        setCornerRadius(radius: 10)
    }
    
    /// Add shadow
    private func addShadowToCard(shadowRadius: CGFloat = 8.0, shadowOpacity: Float = 0.7, shadowColor: CGColor = UIColor.gray.cgColor, shadowOffset: CGSize = CGSize(width: 0, height: 5)) {
        cardView.layer.shadowColor = shadowColor
        cardView.layer.shadowOffset = shadowOffset
        cardView.layer.shadowRadius = shadowRadius
        cardView.layer.shadowOpacity = shadowOpacity
    }
    
    private func setCornerRadius(radius: CGFloat) {
        cardView.layer.cornerRadius = radius
    }

}
