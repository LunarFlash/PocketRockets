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
    let rocketAnimationView: AnimationView = {
        let animationView = AnimationView()
        animationView.loopMode = .loop
        return animationView
    }()
    /// Label displaying countdown for the next SpaceX rocket launch.
    let countdownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.textAlignment = .center
        return label
    }()
    /// Label displaying subscript text: next launch is in...
    let subscriptLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.text = "next launch is in..."
        return label
    }()
    
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
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    // Implement this to allow storyboard to render our custom view.
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupConstraints()
    }
}

extension LaunchHeaderView {
    /// Setup  animations and countdown label.
    private func setupConstraints() {
        setupAnimationView()
    }
    
    /// Setup animation view.
    private func setupAnimationView() {
        addSubview(rocketAnimationView)
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
        addSubview(countdownLabel)
        countdownLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(subscriptLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupSubscriptLabel() {
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
