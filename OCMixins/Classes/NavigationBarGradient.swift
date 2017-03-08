//
//  NavigationBarGradient.swift
//  VidaPrevidencia
//
//  Created by Cristian Madrid on 20/01/17.
//  Copyright © 2017 Porto Seguro. All rights reserved.
//

import UIKit
public enum GradientOrientation {
    case horizontal, vertical
    
    var startPoint: CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: 0.0, y: 0.5)
        case .vertical:
            return CGPoint(x: 0.5, y: 0)
        }
    }
    
    var endPoint: CGPoint {
        switch self {
        case .horizontal:
            return CGPoint(x: 1.0, y: 0.5)
        case .vertical:
            return CGPoint(x: 0.5, y: 1)
        }
    }
}

public protocol NavigationBarGradient {
    func setupNavigationBarGradient(orientation: GradientOrientation, colors: [UIColor])
    func removeGradientFromNavigationBar()
}

struct DefaultValues {
    var backgroundImage: UIImage?
    var shadowImage: UIImage?
    var isTranslucid: Bool?
    var gradientView: UIView?
}

fileprivate var defaultValues = DefaultValues()
public extension NavigationBarGradient where Self: UIViewController {
    
    func removeGradientFromNavigationBar() {
        
        guard let navigationController = navigationController else {
            return
        }
        
        navigationController.navigationBar.setBackgroundImage(defaultValues.backgroundImage, for: .default)
        navigationController.navigationBar.shadowImage = defaultValues.shadowImage
        navigationController.navigationBar.isTranslucent = defaultValues.isTranslucid ?? false
        defaultValues.gradientView?.removeFromSuperview()
    }
    
    func setupNavigationBarGradient(orientation: GradientOrientation, colors: [UIColor]) {
        guard let navigationController = navigationController else {
            return
        }
        
        setupNavigationBarTransparent()
        
        let navigationBar = navigationController.navigationBar
        let layer = getGradientLayer(orientation: orientation, colors: colors.flatMap { $0.cgColor })
        let width = UIApplication.shared.statusBarFrame.width
        let height = UIApplication.shared.statusBarFrame.height + navigationController.navigationBar.frame.height
        
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        gradientView.layer.insertSublayer(layer, at: 0)
        
        defaultValues.gradientView = gradientView
        navigationController.view.insertSubview(gradientView, belowSubview: navigationBar)
    }
    
    final fileprivate func setupNavigationBarTransparent() {
        guard let navigationController = navigationController else {
            return
        }
        
        defaultValues.backgroundImage = navigationController.navigationBar.backgroundImage(for: .default)
        defaultValues.shadowImage = navigationController.navigationBar.shadowImage
        defaultValues.isTranslucid = navigationController.navigationBar.isTranslucent
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
    }
    
    final fileprivate func getGradientLayer(orientation: GradientOrientation, colors: [CGColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        
        guard let navigationController = navigationController else {
            return layer
        }
        
        layer.colors = colors
        layer.startPoint = orientation.startPoint
        layer.endPoint = orientation.endPoint
        
        let navBarFrame = navigationController.navigationBar.bounds
        let statusFrame = UIApplication.shared.statusBarFrame
        layer.frame = CGRect(x: navBarFrame.minX,
                             y: 0,
                             width: navBarFrame.width,
                             height: navBarFrame.height + statusFrame.height + 1)
        return layer
    }
}
