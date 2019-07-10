//
//  LaunchHeaderView.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/9/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

@IBDesignable class LaunchHeaderView: UIView {
    
    /// View animating a rocket
    let rocketAnimationView = AnimationView()
    /// Label displaying countdown for the next SpaceX rocket launch.
    let countdownLabel = UILabel()
    /// Label displaying subscript text: next launch is in...
    let subscriptLabel = UILabel()
    
    /// State variable for countdown
    var launchInterval: TimeInterval? {
        didSet {
            countdownLabel.fadeTransition(0.4)
            countdownLabel.text = self.launchInterval?.toClock()
        }
    }
    
    private var timer = Timer()
    
    /// Date of the next SpaceX rocket launch.
    var nextLaunchDate: Date?
    
    // Called after the view and its subviews were allocated and initialized. It is guaranteed that the view will have all its outlet instance variables set. If initWithCoder: is the beginning of the nib unarchiving process, then awakeFromNib is the end.
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // Implement this to allow storyboard to render our custom view.
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
}

extension LaunchHeaderView {
    /// Setup  animations and countdown label.
    private func setupUI() {
        countdownLabel.text = ""
        countdownLabel.font = UIFont.systemFont(ofSize: 40, weight: .black)
        setupAnimationView()
    }
    
    /// Setup animation view.
    private func setupAnimationView() {
        addSubview(rocketAnimationView)
        rocketAnimationView.loopMode = .loop
        rocketAnimationView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(self).offset(0)
            setupSubscriptLabel()
        }
        rocketAnimationView.animation = Animation.named("rocket_flying")
        rocketAnimationView.play()
    }
    
    /// Setup the , launch countdown label
    private func setupCountdownLabel() {
        countdownLabel.textAlignment = .center
        addSubview(countdownLabel)
        countdownLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(subscriptLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupSubscriptLabel() {
        subscriptLabel.textAlignment = .center
        subscriptLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        subscriptLabel.text = "next launch is in..."
        addSubview(subscriptLabel)
        subscriptLabel.snp.makeConstraints { (make) in
            make.height.equalTo(14)
            make.top.equalTo(rocketAnimationView.snp.bottom).offset(0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            setupCountdownLabel()
        }
    }
    
    /// Start the timer
    func runTimer(with launchDate: Date) {
        self.nextLaunchDate = launchDate
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(fire)), userInfo: nil, repeats: true)
    }
    
    /// Update the countdowb time interval
    @objc func fire() {
        launchInterval = nextLaunchDate?.timeIntervalSinceNow
    }
}
