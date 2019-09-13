//
//  DDTabBarItem.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 1/8/19.
//

import Foundation

open class DDTabBarItem: UIButton {
    private var icon: UIImage?
    private var selectedIcon: UIImage?
    private var title: String?
    private var iconHeight: CGFloat = DDConstant.iconHeight
    open var iconImageView: UIImageView?
    open var ddTitleLabel: UILabel?
    open var ddContentWrapperView: UIView?
    var height: CGFloat = -1
    
    open override var isSelected: Bool {
        didSet {
            self.iconImageView?.image = isSelected ? selectedIcon : icon
        }
    }
    
    public convenience init(height: CGFloat = -1, icon: UIImage, selectedIcon: UIImage? = nil, title: String?, iconHeight: CGFloat = DDConstant.iconHeight, backgroundImage: UIImage? = nil, wrapperMode: DDWrapperMode = .normal) {
        self.init()
        self.height = height
        setupDDContentWrapperView(wrapperMode: wrapperMode)
        setupIcon(with: icon, selectedImage: selectedIcon ?? icon, iconHeight: iconHeight)
        setupTitle(withTitle: title)
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
    
    func setupIcon(with image: UIImage, selectedImage: UIImage, iconHeight: CGFloat) {
        self.icon = image
        self.selectedIcon = selectedImage
        let imageView = UIImageView()
        ddContentWrapperView?.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.iconHeight = iconHeight
        
        // Constraints
        imageView.widthHeightRatio(ratio: 1)
        imageView.equalWidth(toView: self, constant: -10, relatedBy: .lessThanOrEqual)
        imageView.equalHeight(toView: self, relatedBy: .lessThanOrEqual)
        imageView.centerX(toView: self)
        imageView.height(iconHeight, priority: .init(999))
        imageView.top(toView: ddContentWrapperView, constant: 10)
        imageView.leading(toView: ddContentWrapperView, relatedBy: .greaterThanOrEqual)
        imageView.trailing(toView: ddContentWrapperView, relatedBy: .lessThanOrEqual)
        
        iconImageView = imageView
    }
    
    func setupTitle(withTitle title: String?) {
        let label = UILabel()
        ddContentWrapperView?.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = DDConstant.barItemColor
        label.contentMode = .center
        label.font = DDConstant.barItemTitleFont
        
        // Constraints
        label.equalWidth(toView: self, constant: -10, relatedBy: .lessThanOrEqual)
        label.topSpacing(toView: iconImageView, constant: 0)
        label.centerX(toView: self)
        label.bottom(toView: ddContentWrapperView, constant: -10, relatedBy: .lessThanOrEqual)
        label.leading(toView: ddContentWrapperView, relatedBy: .greaterThanOrEqual)
        label.trailing(toView: ddContentWrapperView, relatedBy: .lessThanOrEqual)
        ddTitleLabel = label
    }
    
    open func setIcon(withImage image: UIImage?, selectedImage: UIImage?) {
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
