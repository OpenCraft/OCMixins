//
//  TransparentModal.swift
//  ShowDoMilhao
//
//  Created by Henrique Morbin on 30/07/16.
//  Copyright © 2016 Movile. All rights reserved.
//

import Foundation

public protocol TransparentModal: class {
    func applyTransparentBackground()
    var transparency: CGFloat {get set}
    var transparencyAnimated: (CGFloat, NSTimeInterval?) {get set}
}

public extension TransparentModal where Self: UIViewController {
    
    public func applyTransparentBackground() {
        modalPresentationStyle = .OverCurrentContext
        view.backgroundColor = UIColor.clearColor()
    }
    
    public var transparency: CGFloat {
        get {
            return transparency
        }
        set {
            self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(newValue)
        }
    }
    
    public var transparencyAnimated: (CGFloat, NSTimeInterval?) {
        get {
            return transparencyAnimated
        }
        set {
            UIView.animateWithDuration(newValue.1 ?? 0.0) {
                self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(newValue.0)
            }
        }
    }
    
}
