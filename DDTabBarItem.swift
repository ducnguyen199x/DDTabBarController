//
//  DDTabBarItem.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 1/8/19.
//

import Foundation

open class DDTabBarItem: UIButton {
    open var iconImageView: UIImageView?
    private var icon: UIImage?
    open var ddTitleLabel: UILabel?
    private var title: String?
    private var iconHeight: CGFloat = 50
    var height: CGFloat = -1
    open private(set) var ddBackgroundImage: UIImage?
    open var ddBackgroundImageView: UIImageView?
    
    public convenience init(height: CGFloat = -1, icon: UIImage, title: String?, iconHeight: CGFloat = 35, backgroundImage: UIImage? = nil) {
        self.init()
        self.height = height
        setupDDBackgroundImageView(withImage: backgroundImage)
        setupIcon(withImage: icon, iconHeight: iconHeight)
        setupTitle(withTitle: title)
    }
    
    func setupDDBackgroundImageView(withImage image: UIImage?) {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        // Constraints
        imageView.widthHeightRatio(ratio: 1)
        imageView.equalWidth(toView: self, multiplier: 1)
        imageView.equalHeight(toView: self, multiplier: 1, relatedBy: .lessThanOrEqual)
        imageView.centerX(toView: self)
        imageView.top(toView: self)

        ddBackgroundImageView = imageView
    }
    
    func setupIcon(withImage image: UIImage, iconHeight: CGFloat) {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.iconHeight = iconHeight
        
        // Constraints
        imageView.widthHeightRatio(ratio: 1)
        imageView.equalWidth(toView: self, multiplier: 1, relatedBy: .lessThanOrEqual)
        imageView.equalHeight(toView: self, multiplier: 1, relatedBy: .lessThanOrEqual)
        imageView.centerX(toView: self)
        imageView.top(toView: self, constant: 10)
        imageView.height(iconHeight, priority: .init(999))
        
        iconImageView = imageView
    }
    
    func setupTitle(withTitle title: String?) {
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.contentMode = .center
        label.font = .systemFont(ofSize: 14.0)
        
        // Constraints
        label.equalWidth(toView: self, multiplier: 1, relatedBy: .lessThanOrEqual)
        label.topSpacing(toView: iconImageView, constant: 0)
        label.centerX(toView: self)
        label.bottom(toView: self, constant: 10,relatedBy: .lessThanOrEqual)
        ddTitleLabel = label
    }
    
    open func setIcon(withImage image: UIImage?) {
        self.icon = image
        self.iconImageView?.image = image
    }
    
    open func setTitle(_ title: String?) {
        self.title = title
        self.ddTitleLabel?.text = title
    }
    
    open func setDDBackgroundImage(_ image: UIImage?) {
        ddBackgroundImage = image
        ddBackgroundImageView?.image = image
    }
}
