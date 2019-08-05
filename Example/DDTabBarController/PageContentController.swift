//
//  PageContentController.swift
//  DDTabBarController_Example
//
//  Created by Nguyen Thanh Duc on 5/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class PageContentController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonDidTap(_ sender: Any) {
        count += 1
        label.text = "\(count)"
    }
}
