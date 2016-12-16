//
//  TransparentModal.swift
//  
//
//  Created by Henrique Morbin on 30/07/16.
//  Copyright © 2016 Movile. All rights reserved.
//

import Foundation

public protocol TransparentModal: class {
    func applyTransparentBackground()
    var transparency: CGFloat {get set}
    var transparencyAnimated: (CGFloat, TimeInterval?) {get set}
}

public extension TransparentModal where Self: UIViewController {
    
    open func applyTransparentBackground() {
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor.clear
    }
    
    open var transparency: CGFloat {
        get {
            return transparency
        }
        set {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(newValue)
        }
    }
    
    open var transparencyAnimated: (CGFloat, TimeInterval?) {
        get {
            return transparencyAnimated
        }
        set {
            UIView.animate(withDuration: newValue.1 ?? 0.0, animations: {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(newValue.0)
            }) 
        }
    }
    
}
