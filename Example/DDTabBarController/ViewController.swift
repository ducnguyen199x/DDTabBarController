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
        setupUI()
    }
    
    func setupUI() {
        let calendar = DDTabBarItem(icon: #imageLiteral(resourceName: "calendar"),title: "Calendar")
        let location = DDTabBarItem(icon: #imageLiteral(resourceName: "location"), title: "Location")
        let onNow = DDTabBarItem(height: 110,icon: #imageLiteral(resourceName: "play"), title: "On Now")
        let timer = DDTabBarItem(icon: #imageLiteral(resourceName: "timer"), title: "Time")
        let account = DDTabBarItem(icon: #imageLiteral(resourceName: "account"), title: "Account")
        
        let vc1 = UIViewController()
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
}

