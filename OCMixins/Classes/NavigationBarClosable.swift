//
//  NavigationBarClosable.swift
//  VidaPrevidencia
//
//  Created by Cristian Madrid on 12/29/16.
//  Copyright © 2016 Porto Seguro. All rights reserved.
//

enum NavigationSide {
    case right, left
}

protocol NavigationBarClosable {
    func setupNavigationCloseButton(at navigationSide: NavigationSide)
}

extension NavigationBarClosable where Self: UIViewController {
    
    func setupNavigationCloseButton(at navigationSide: NavigationSide) {
        if navigationSide == .right {
            navigationItem.setRightBarButtonItem(barButtonSystemItem: .stop) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            
        } else if navigationSide == .left {
            navigationItem.setLeftBarButtonItem(barButtonSystemItem: .stop) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
