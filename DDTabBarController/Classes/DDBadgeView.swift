//
//  DDBadgeView.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 20/9/19.
//

import UIKit

open class DDBadgeView: UIView {
    open var badgeCountLabel = UILabel()
    
    convenience init(width: CGFloat) {
        self.init()
        setupView()
    }
    
    open override func didMoveToSuperview() {
        // Constraints
        widthHeightRatio(ratio: 1)
        addSubview(badgeCountLabel)
        badgeCountLabel.equalWidth(toView: self)
        badgeCountLabel.equalHeight(toView: self)
        badgeCountLabel.centerX(toView: self)
        badgeCountLabel.centerY(toView: self)
    }
    
    func setupView() {
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        badgeCountLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeCountLabel.contentMode = .center
        badgeCountLabel.textAlignment = .center
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width/2
    }
}
