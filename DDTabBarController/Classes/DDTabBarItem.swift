//
//  DDTabBarItem.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 1/8/19.
//

import Foundation

public struct DDIcon {
    var image: UIImage
    var selectedImage: UIImage
    var height: CGFloat
    var topPadding: CGFloat
    var bottomPadding: CGFloat
    
    public init(image: UIImage,
         selectedImage: UIImage? = nil,
         height: CGFloat = DDConstant.iconHeight,
         topPadding: CGFloat = DDConstant.iconTopPadding,
         bottomPadding: CGFloat = DDConstant.iconBottomPadding) {
        self.image = image
        self.selectedImage = selectedImage ?? image
        self.height = height
        self.topPadding = topPadding
        self.bottomPadding = bottomPadding
    }
}

open class DDTabBarItem: UIButton {
    private var icon = UIImage()
    private var selectedIcon = UIImage()
    private var title: String?
    private var iconHeight: CGFloat = DDConstant.iconHeight
    open var iconImageView: UIImageView?
    open var ddTitleLabel: UILabel?
    open var ddContentWrapperView: UIView?
    open var ddBadgeView: DDBadgeView?
    var height: CGFloat = -1
    
    private var badgeTopConstraint: NSLayoutConstraint?
    private var badgeLeadingConstraint: NSLayoutConstraint?
    private var badgeWidthConstraint: NSLayoutConstraint?
    
    open var badgeWidth: CGFloat = DDConstant.badgeWidth {
        didSet {
            badgeWidthConstraint?.constant = badgeWidth
        }
    }
    
    open var badgeLeftInset: CGFloat = DDConstant.badgeLeftInset {
        didSet {
            badgeLeadingConstraint?.constant = badgeLeftInset
        }
    }
    
    open var badgeTopInset: CGFloat = DDConstant.badgeTopInset {
        didSet {
            badgeTopConstraint?.constant = badgeTopInset
        }
    }

    open override var isSelected: Bool {
        didSet {
            self.iconImageView?.image = isSelected ? selectedIcon : icon
        }
    }
    
    public convenience init(height: CGFloat = -1,
                            icon: DDIcon,
                            title: String?,
                            backgroundImage: UIImage? = nil,
                            wrapperMode: DDWrapperMode = .normal) {
        self.init()
        self.height = height
        setupDDContentWrapperView(wrapperMode: wrapperMode)
        setupIcon(with: icon)
        setupTitle(withTitle: title, topPadding: icon.bottomPadding)
        setupBadge()
    }
    
    func setupDDContentWrapperView(wrapperMode: DDWrapperMode = .normal) {
        let wrapperView = DDWrapperView(wrapperMode: wrapperMode)
        addSubview(wrapperView)
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.isUserInteractionEnabled = false
        wrapperView.clipsToBounds = true
        
        // Constraints
        wrapperView.top(toView: self)
        wrapperView.widthHeightRatio(ratio: 1)
        wrapperView.centerX(toView: self)

        ddContentWrapperView = wrapperView
    }
    
    func setupIcon(with icon: DDIcon) {
        self.icon = icon.image
        self.selectedIcon = icon.selectedImage
        let imageView = UIImageView()
        ddContentWrapperView?.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = icon.image
        self.iconHeight = icon.height
        
        // Constraints
        imageView.widthHeightRatio(ratio: 1)
        imageView.equalWidth(toView: self, constant: -10, relatedBy: .lessThanOrEqual)
        imageView.equalHeight(toView: self, relatedBy: .lessThanOrEqual)
        imageView.centerX(toView: self)
        imageView.height(iconHeight, priority: .init(999))
        imageView.top(toView: ddContentWrapperView, constant: icon.topPadding)
        imageView.leading(toView: ddContentWrapperView, relatedBy: .greaterThanOrEqual)
        imageView.trailing(toView: ddContentWrapperView, relatedBy: .lessThanOrEqual)
        
        iconImageView = imageView
    }
    
    func setupTitle(withTitle title: String?, topPadding: CGFloat) {
        let label = UILabel()
        ddContentWrapperView?.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = DDConstant.barItemColor
        label.contentMode = .center
        label.font = DDConstant.barItemTitleFont
        
        // Constraints
        label.equalWidth(toView: self, constant: -10, relatedBy: .lessThanOrEqual)
        label.topSpacing(toView: iconImageView, constant: topPadding)
        label.centerX(toView: self)
        label.bottom(toView: ddContentWrapperView, constant: -7, relatedBy: .lessThanOrEqual)
        label.leading(toView: ddContentWrapperView, relatedBy: .greaterThanOrEqual)
        label.trailing(toView: ddContentWrapperView, relatedBy: .lessThanOrEqual)
        label.height(12)
        ddTitleLabel = label
    }
    
    func setupBadge() {
        let badgeView = DDBadgeView(width: 8)
        badgeView.backgroundColor = .red
        addSubview(badgeView)
        ddBadgeView = badgeView
        badgeTopConstraint = badgeView.top(toView: self, constant: badgeTopInset)
        badgeLeadingConstraint = badgeView.leading(toView: self, constant: badgeLeftInset)
        badgeWidthConstraint = badgeView.width(badgeWidth)
        ddBadgeView?.isHidden = true
    }
    
    func showBadge(_ count: Int?) {
        if let count = count {
            ddBadgeView?.badgeCountLabel.text = "\(count)"
        } else {
            ddBadgeView?.badgeCountLabel.text = nil
        }
        ddBadgeView?.isHidden = false
    }
    
    func hideBadge() {
        ddBadgeView?.isHidden = true
    }
    
    open func setIcon(withImage image: UIImage, selectedImage: UIImage) {
        self.icon = image
        self.selectedIcon = selectedImage
        self.iconImageView?.image = isSelected ? selectedImage : image
    }
    
    open func setTitle(_ title: String?) {
        self.title = title
        self.ddTitleLabel?.text = title
    }
    
    open func setDDBackgroundImage(_ image: UIImage?) {
    }
    
    func setColor(_ color: UIColor) {
        tintColor = color
        ddTitleLabel?.textColor = color
    }
}
