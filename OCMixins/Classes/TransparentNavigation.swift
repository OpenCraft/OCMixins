//
//  TransparentNavigation.swift
//  ShowDoMilhao
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
            return view.layer.valueForKey(transparentNavigationTransparentKey) as? Bool ?? false
        }
        set {
            view.layer.setValue(newValue, forKey: transparentNavigationTransparentKey)
            updateNavBarState()
        }
    }
    
    private var optionsCache: OptionsCache? {
        get {
            return view.layer.valueForKey(transparentNavigationOptionsCacheKey) as? OptionsCache
        }
        set {
            view.layer.setValue(newValue, forKey: transparentNavigationOptionsCacheKey)
        }
    }
    
    private func updateNavBarState() {
        updateOptionsCache()
        
        if transparentNavigationBar ?? false {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.translucent = true
            navigationController?.navigationBar.barTintColor = UIColor.clearColor()
            navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        } else {
            navigationController?.navigationBar.setBackgroundImage(optionsCache?.backgroundImage, forBarMetrics: .Default)
            navigationController?.navigationBar.shadowImage = optionsCache?.shadowImage
            navigationController?.navigationBar.translucent = optionsCache?.translucent ?? true
            navigationController?.navigationBar.barTintColor = optionsCache?.barTintColor
            navigationController?.navigationBar.tintColor = optionsCache?.tintColor
        }
    }
    
    private func updateOptionsCache() {
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
        backgroundImage = navigationController?.navigationBar.backgroundImageForBarMetrics(UIBarMetrics.Default)
        shadowImage = navigationController?.navigationBar.shadowImage
        translucent = navigationController?.navigationBar.translucent
        tintColor = navigationController?.navigationBar.tintColor
        barTintColor = navigationController?.navigationBar.barTintColor
    }
}
