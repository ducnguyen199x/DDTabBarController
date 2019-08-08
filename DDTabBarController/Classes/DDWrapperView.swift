//
//  DDWrapperView.swift
//  DDTabBarController
//
//  Created by Nguyen Thanh Duc on 6/8/19.
//

public enum DDWrapperMode {
    case normal
    case rounded
}

class DDWrapperView: UIView {
    open var wrapperMode: DDWrapperMode = .normal
    
    convenience init(wrapperMode: DDWrapperMode) {
        self.init()
        self.wrapperMode = wrapperMode
        setupView()
    }
    
    func setupView() {
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch wrapperMode {
        case .normal:
            break
        case .rounded:
            layer.cornerRadius = frame.width/2
            break
        }
    }
}
