//
//  PageContentController.swift
//  DDTabBarController_Example
//
//  Created by Nguyen Thanh Duc on 5/8/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol PageContentControllerDelegate: class {
    func didTapToggleTabBar(_ pageContentController: PageContentController, isHidden: Bool)
}

class PageContentController: UIViewController {
    @IBOutlet weak var label: UILabel!
    var count = 1
    weak var delegate: PageContentControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonDidTap(_ sender: Any) {
        count += 1
        label.text = "\(count)"
        delegate?.didTapToggleTabBar(self, isHidden: count % 2 == 0)
    }
}
