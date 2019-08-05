//
//  DDTabBarController.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 31/7/19.
//

import Foundation

open class DDTabBarController: UITabBarController {
    open var ddTabBar: DDTabBar?
    private var ddTabBarHeight: CGFloat = DDConstant.tabBarHeight
    private var barItemColor: UIColor = DDConstant.barItemColor {
        didSet {
            ddTabBar?.tintColor = barItemColor
        }
    }
    private var barItemSelectedColor: UIColor = DDConstant.barItemSelectedColor {
        didSet {
            ddTabBar?.barItem(at: selectedIndex)?.setColor(barItemSelectedColor)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
    }
    
    open func setTabBar(items: [DDTabBarItem], height: CGFloat = DDConstant.tabBarHeight) {
        guard !items.isEmpty else { return }
        ddTabBarHeight = height
        let tabBar = DDTabBar(items: items, height: height)
        ddTabBar = tabBar
        ddTabBar?.tintColor = barItemColor
        ddTabBar?.barItem(at: 0)?.setColor(barItemSelectedColor)
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
    
    open func setBarItemColor(_ color: UIColor) {
        barItemColor = color
    }
    
    open func setBarItemSelectedColor(_ color: UIColor) {
        barItemSelectedColor = color
    }
    
    @objc func switchTap(sender: UIButton) {
        let newIndex = sender.tag
        changeTab(from: selectedIndex, to: newIndex)
    }
    
    private func changeTab(from fromIndex: Int, to toIndex: Int) {
        ddTabBar?.barItem(at: fromIndex)?.setColor(barItemColor)
        ddTabBar?.barItem(at: toIndex)?.setColor(barItemSelectedColor)
        selectedIndex = toIndex
    }
}
