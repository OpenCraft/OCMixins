//
//  TransparentNavigation.swift
//  
//
//  Created by Henrique Morbin on 18/07/16.
//  Copyright © 2016 Movile. All rights reserved.
//

import Foundation

public protocol TransparentNavigation: class {
    var transparentNavigationBar: Bool {get set}
}

public extension TransparentNavigation where Self: UIViewController {
    
    public var transparentNavigationBar: Bool {
        get {
            return view.layer.value(forKey: transparentNavigationTransparentKey) as? Bool ?? false
        }
        set {
            view.layer.setValue(newValue, forKey: transparentNavigationTransparentKey)
            updateNavBarState()
        }
    }
    
    fileprivate var optionsCache: OptionsCache? {
        get {
            return view.layer.value(forKey: transparentNavigationOptionsCacheKey) as? OptionsCache
        }
        set {
            view.layer.setValue(newValue, forKey: transparentNavigationOptionsCacheKey)
        }
    }
    
    fileprivate func updateNavBarState() {
        updateOptionsCache()
        
        if transparentNavigationBar {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.barTintColor = UIColor.clear
            navigationController?.navigationBar.tintColor = UIColor.white
        } else {
            navigationController?.navigationBar.setBackgroundImage(optionsCache?.backgroundImage, for: .default)
            navigationController?.navigationBar.shadowImage = optionsCache?.shadowImage
            navigationController?.navigationBar.isTranslucent = optionsCache?.translucent ?? true
            navigationController?.navigationBar.barTintColor = optionsCache?.barTintColor
            navigationController?.navigationBar.tintColor = optionsCache?.tintColor
        }
    }
    
    fileprivate func updateOptionsCache() {
        if optionsCache == nil {
            optionsCache = OptionsCache(withNavigationController: navigationController)
        }
    }
    
}

private let transparentNavigationTransparentKey = "transparent_key"
private let transparentNavigationOptionsCacheKey = "options_cache_key"

private class OptionsCache {
    let backgroundImage: UIImage?
    let shadowImage: UIImage?
    let translucent: Bool?
    let tintColor: UIColor?
    let barTintColor: UIColor?
    
    init(withNavigationController navigationController: UINavigationController?) {
        backgroundImage = navigationController?.navigationBar.backgroundImage(for: UIBarMetrics.default)
        shadowImage = navigationController?.navigationBar.shadowImage
        translucent = navigationController?.navigationBar.isTranslucent
        tintColor = navigationController?.navigationBar.tintColor
        barTintColor = navigationController?.navigationBar.barTintColor
    }
}
