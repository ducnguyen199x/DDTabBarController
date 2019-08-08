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
        let calendar = DDTabBarItem(icon: #imageLiteral(resourceName: "calendar"),title: "Calendar")
        let location = DDTabBarItem(icon: #imageLiteral(resourceName: "location"), title: "Location")
        let onNow = DDTabBarItem(height: 100,icon: #imageLiteral(resourceName: "play"), title: "On Now", wrapperMode: .rounded)
        let timer = DDTabBarItem(icon: #imageLiteral(resourceName: "timer"), title: "Time")
        let account = DDTabBarItem(icon: #imageLiteral(resourceName: "account"), title: "Account")
        
        onNow.ddContentWrapperView?.layer.borderWidth = 0.5
        onNow.ddContentWrapperView?.layer.borderColor = UIColor.black.cgColor
        
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
        
        setTabBar(items: [calendar, location, onNow, timer, account], height: 90)
        viewControllers = [vc1, vc2, vc3, vc4, vc5]
        ddTabBar?.backgroundColor = .black
    }
    
    func viewController(for identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension ViewController: DDTabBarControllerDelegate {
    func ddTabBar(_ ddTabBar: DDTabBar, didSwitch fromItem: DDTabBarItem, toItem: DDTabBarItem) {
        let fromIndex = ddTabBar.ddBarItems.index(of: fromItem)
        let toIndex = ddTabBar.ddBarItems.index(of: toItem)
        
        if fromIndex == 2 {
            fromItem.ddContentWrapperView?.backgroundColor = .white
        }
        
        if toIndex == 2 {
            toItem.ddContentWrapperView?.backgroundColor = .lightGray
        }
    }
}

extension ViewController: PageContentControllerDelegate {
    func didTapToggleTabBar(_ pageContentController: PageContentController, isHidden: Bool) {
        isHidden ? hideTabBar(animationDuration: 0.25) : showTabBar(animationDuration: 0.25)
    }
}
