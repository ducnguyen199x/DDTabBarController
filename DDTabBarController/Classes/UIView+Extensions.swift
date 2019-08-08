//
//  UIView+Extensions.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 1/8/19.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func width(_ width: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func height(_ height: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func widthHeightRatio(ratio: CGFloat, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: ratio, constant: 0)
        constraint.priority = priority
        addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func equalWidth(toView view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, relatedBy relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: relation, toItem: view, attribute: .width, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func equalHeight(toView view: UIView?, constant: CGFloat = 0, multiplier: CGFloat = 1, relatedBy relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: relation, toItem: view, attribute: .height, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func leading(toView view: UIView?, constant: CGFloat = 0, relatedBy relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relation, toItem: view, attribute: .leading, multiplier: 1, constant: constant)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func trailing(toView view: UIView?, constant: CGFloat = 0, relatedBy relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: relation, toItem: view, attribute: .trailing, multiplier: 1, constant: constant)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func top(toView view: UIView?, constant: CGFloat = 0, relatedBy relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: view, attribute: .top, multiplier: 1, constant: constant)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func topSpacing(toView view: UIView?, constant: CGFloat = 0, relatedBy relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: relation, toItem: view, attribute: .bottom, multiplier: 1, constant: constant)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }

    @discardableResult
    func bottom(toView view: UIView?, constant: CGFloat = 0, relatedBy relation: NSLayoutConstraint.Relation = .equal, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: relation, toItem: view, attribute: .bottom, multiplier: 1, constant: constant)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func centerX(toView view: UIView?, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func centerY(toView view: UIView?, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        constraint.priority = priority
        (highestSuperview() ?? view)?.addConstraint(constraint)
        return constraint
    }
    
    func highestSuperview() -> UIView? {
        return superview?.highestSuperview() ?? superview
    }
}
