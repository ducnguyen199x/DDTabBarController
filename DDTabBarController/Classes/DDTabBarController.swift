//
//  DDTabBarController.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 31/7/19.
//

import Foundation

@objc public protocol DDTabBarControllerDelegate: class {
    @objc optional func ddTabBarController(_ ddTabBarController: DDTabBarController, didSelect viewController: UIViewController)
    @objc optional func ddTabBar(_ ddTabBar: DDTabBar, didSwitch fromItem: DDTabBarItem, toItem: DDTabBarItem)
}

open class DDTabBarController: UITabBarController {
    open var ddTabBar: DDTabBar?
    open var ddDelegate: DDTabBarControllerDelegate?
    private var ddTabBarHeight: CGFloat = DDConstant.tabBarHeight
    private var barItemColor: UIColor = DDConstant.barItemColor {
        didSet {
            ddTabBar?.tintColor = barItemColor
        }
    }
    private var barItemSelectedColor: UIColor = DDConstant.barItemSelectedColor {
        didSet {
            let selectedIndex = (self.selectedIndex == Int.max) ? 0 : self.selectedIndex
            ddTabBar?.barItem(at: selectedIndex)?.setColor(barItemSelectedColor)
        }
    }
    
    // Constraint Properties
    var bottomConstraint: NSLayoutConstraint?
    
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
        bottomConstraint = tabBar.bottom(toView: view)
        
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
        let previousItem = ddTabBar?.barItem(at: fromIndex)
        let nextItem = ddTabBar?.barItem(at: toIndex)

        previousItem?.setColor(barItemColor)
        nextItem?.setColor(barItemSelectedColor)
        selectedIndex = toIndex
        
        if let ddTabBar = ddTabBar, let previousItem = previousItem, let nextItem = nextItem {
            ddDelegate?.ddTabBar?(ddTabBar, didSwitch: previousItem, toItem: nextItem)
        }
        
        if let selectedViewController = viewController(at: toIndex) {
            ddDelegate?.ddTabBarController?(self, didSelect: selectedViewController)
        }
    }
    
    open func viewController(at index: Int) -> UIViewController? {
        guard index >= 0 && index < viewControllers?.count ?? 0 else { return nil }
        return viewControllers?[index]
    }
    
    open func hideTabBar(animationDuration: TimeInterval = 0) {
        guard let ddTabBar = ddTabBar, ddTabBar.showedUp else { return }
        toggleTabBar(true, animationDuration: animationDuration)
        ddTabBar.showedUp = false
    }
    
    open func showTabBar(animationDuration: TimeInterval = 0) {
        guard let ddTabBar = ddTabBar, !ddTabBar.showedUp else { return }
        toggleTabBar(false, animationDuration: animationDuration)
        ddTabBar.showedUp = true
    }
    
    func toggleTabBar(_ isHidden: Bool, animationDuration: TimeInterval = 0) {
        if !isHidden {
            self.ddTabBar?.isHidden = isHidden
        }
        
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            self?.bottomConstraint?.constant = isHidden ? self?.ddTabBar?.maxHeight ?? 0 : 0
            self?.view.layoutIfNeeded()
        }) { [weak self] _ in
            if isHidden {
                self?.ddTabBar?.isHidden = isHidden
            }
        }
    }
}
