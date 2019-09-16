//
//  ViewController.swift
//  DDTabBarController
//
//  Created by Duc Nguyen on 07/31/2019.
//  Copyright (c) 2019 Duc Nguyen. All rights reserved.
//

import UIKit
import DDTabBarController

class ViewController: DDTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ddDelegate = self
        setupUI()
    }
    
    func setupUI() {
        
        let calendar = DDTabBarItem(icon: DDIcon(image: #imageLiteral(resourceName: "calendar"), height: 24), title: "Calendar")
        let location = DDTabBarItem(icon: DDIcon(image: #imageLiteral(resourceName: "location"), height: 24), title: "Location")
        let onNow = DDTabBarItem(height: 84, icon: DDIcon(image: #imageLiteral(resourceName: "play-unselected"), selectedImage: #imageLiteral(resourceName: "play"), height: 24, topPadding: 16, bottomPadding: 8), title: "On Now", wrapperMode: .rounded)
        let timer = DDTabBarItem(icon: DDIcon(image: #imageLiteral(resourceName: "timer"), height: 24), title: "Time")
        let account = DDTabBarItem(icon: DDIcon(image: #imageLiteral(resourceName: "account"), height: 24), title: "Account")
        
        onNow.ddContentWrapperView?.addBackgroundGradient(colors: [#colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1), #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)], vertical: true, bounds: CGRect(x: 0, y: 0, width: 72, height: 72))
        
        let vc1 = viewController(for: "PageContent") as! PageContentController
        vc1.delegate = self
        vc1.view.backgroundColor = .green
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .blue
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .red
        let vc4 = UIViewController()
        vc4.view.backgroundColor = .yellow
        let vc5 = UIViewController()
        vc5.view.backgroundColor = .brown
        
        setTabBar(items: [calendar, location, onNow, timer, account], height: 80)
        viewControllers = [vc1, vc2, vc3, vc4, vc5]
        setBarItemColor(.lightGray)
        setBarItemSelectedColor(.green)
        ddTabBar?.setBackgroundColor(UIColor(hex6: 0x1A1A1A))
        ddTabBar?.layer.shadowColor = UIColor.black.cgColor
        ddTabBar?.layer.shadowRadius = 10
        ddTabBar?.layer.shadowOpacity = 0.6
        ddTabBar?.layer.shadowOffset = CGSize(width: 0, height: -6)
        changeTab(to: 2)
    }
    
    func viewController(for identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension ViewController: DDTabBarControllerDelegate {
    func ddTabBar(_ ddTabBar: DDTabBar, didSwitch fromItem: DDTabBarItem, toItem: DDTabBarItem) {
//        let fromIndex = ddTabBar.ddBarItems.index(of: fromItem)
//        let toIndex = ddTabBar.ddBarItems.index(of: toItem)
//
//        if fromIndex == 2 {
//            fromItem.ddContentWrapperView?.backgroundColor = .white
//        }
//
//        if toIndex == 2 {
//            toItem.ddContentWrapperView?.backgroundColor = .lightGray
//        }
    }
}

extension ViewController: PageContentControllerDelegate {
    func didTapToggleTabBar(_ pageContentController: PageContentController, isHidden: Bool) {
        isHidden ? hideTabBar(animationDuration: 0.25) : showTabBar(animationDuration: 0.25)
    }
}

extension UIView {
    func addBackgroundGradient(colors: [UIColor] = [#colorLiteral(red: 0.1803921569, green: 0.2274509804, blue: 0.3058823529, alpha: 1), #colorLiteral(red: 0.1882352941, green: 0.2666666667, blue: 0.262745098, alpha: 1)], vertical: Bool = true, bounds: CGRect? = nil) {
        guard layer.sublayers?.first(where: { $0.name == "Background-Gradient"}) == nil else { return }
        let gradient = CAGradientLayer()
        gradient.name = "Background-Gradient"
        gradient.frame = bounds ?? self.bounds
        gradient.colors = colors.map { $0.cgColor }
        if vertical {
            gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        } else {
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        layer.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
