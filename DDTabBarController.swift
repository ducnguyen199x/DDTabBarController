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
    private var barItemColor: UIColor = .blue {
        didSet {
            ddTabBar?.tintColor = barItemColor
        }
    }
    private var barItemSelectedColor: UIColor = .lightGray {
        didSet {
            barItem(atIndex: selectedIndex)?.tintColor = barItemSelectedColor
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
    }
    
    open func setTabBar(items: [DDTabBarItem], height: CGFloat = 40) {
        guard !items.isEmpty else { return }
        ddTabBarHeight = height
        let tabBar = DDTabBar(items: items, height: height)
        ddTabBar = tabBar
        ddTabBar?.tintColor = barItemColor
        barItem(atIndex: 0)?.tintColor = barItemSelectedColor
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
        ddTabBar?.ddBarItems[fromIndex].tintColor = barItemColor
        ddTabBar?.ddBarItems[toIndex].tintColor = barItemSelectedColor
        selectedIndex = toIndex
    }
    
    func barItem(atIndex index: Int) -> DDTabBarItem? {
        guard let ddTabBar = ddTabBar else { return nil }
        guard index >= 0 && index < ddTabBar.ddBarItems.count else { return nil }
        return ddTabBar.ddBarItems[index]
    }
}
