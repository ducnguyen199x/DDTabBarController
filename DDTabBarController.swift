//
//  DDTabBarController.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 31/7/19.
//

import Foundation

open class DDTabBarController: UITabBarController {
    open var ddTabBar: DDTabBar?
    private var ddTabBarHeight: CGFloat = 40
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
    }
    
    open func setTabBar(items: [DDTabBarItem], height: CGFloat = 40) {
        guard !items.isEmpty else { return }
        ddTabBarHeight = height
        let tabBar = DDTabBar(items: items, height: height)
        ddTabBar = tabBar
        view.addSubview(tabBar)
        
        // Constraints
        tabBar.leading(toView: view)
        tabBar.trailing(toView: view)
        tabBar.bottom(toView: view)
        
        for (i, item) in items.enumerated() {
            item.tag = i
            item.addTarget(self, action: #selector(switchTap), for: .touchUpInside)
        }
    }
    
    @objc func switchTap(sender: UIButton) {
        selectedIndex = sender.tag
    }
}
