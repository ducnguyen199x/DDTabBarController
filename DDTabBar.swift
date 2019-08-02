//
//  DDTabBar.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 1/8/19.
//

import Foundation

open class DDTabBar: UITabBar {
    open var ddBarItems: [DDTabBarItem] = []
    private var height: CGFloat = 0
    
    public convenience init(items: [DDTabBarItem], height: CGFloat) {
        self.init()
        ddBarItems = items
        self.height = height
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    open func setupView() {
        backgroundColor = .clear
        
        // Container View
        let containerView = UIView()
        addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
            // Constraints
        containerView.height(height)
        containerView.bottom(toView: self)
        containerView.leading(toView: self)
        containerView.trailing(toView: self)
        
        // Items Stack View
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .bottom
        stackView.distribution = .fillEqually
        
            // Constraints
        stackView.top(toView: self)
        stackView.bottom(toView: self)
        stackView.leading(toView: self)
        stackView.trailing(toView: self)
        
        ddBarItems.forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(item)
            if item.height < 0 {
                item.height(height)
            } else {
                item.height(item.height)
            }
        }
    }
}
