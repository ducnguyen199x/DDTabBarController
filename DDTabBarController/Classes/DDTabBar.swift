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
    var maxHeight: CGFloat = 0
    open var showedUp: Bool = true
    
    public convenience init(items: [DDTabBarItem], height: CGFloat) {
        self.init()
        ddBarItems = items
        self.height = height
        self.maxHeight = height
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    open func setupView() {
        backgroundColor = .white
        tintColor = .red
        height(height)
        
        // Container View
        let containerView = UIView()
        addSubview(containerView)
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
            // Constraints
        containerView.top(toView: self)
        containerView.bottom(toView: self)
        containerView.leading(toView: self)
        containerView.trailing(toView: self)
        
        // Items Stack View
        let stackView = UIStackView()
        containerView.addSubview(stackView)
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .bottom
        stackView.distribution = .fillEqually
        
            // Constraints
        stackView.bottom(toView: containerView)
        stackView.leading(toView: containerView)
        stackView.trailing(toView: containerView)
        
        ddBarItems.forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(item)
            let itemHeight = item.height
            if itemHeight < 0 {
                item.height(height)
            } else {
                item.height(itemHeight)
            }
            if itemHeight > maxHeight {
                maxHeight = itemHeight
            }
        }
    }
    
    open func barItem(at index: Int) -> DDTabBarItem? {
        guard index >= 0 && index < ddBarItems.count else { return nil }
        return ddBarItems[index]
    }
    
    // Provide interation for Items lying outside of TabBar
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for item in ddBarItems {
            let itemPoint = item.convert(point, from: self)
            if item.bounds.contains(itemPoint) {
                return item.hitTest(itemPoint, with: event)
            }
        }
        return super.hitTest(point, with: event)
    }
}
