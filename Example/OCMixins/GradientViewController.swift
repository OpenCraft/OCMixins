//
//  GradientViewController.swift
//  OCMixins
//
//  Created by Cristian Madrid on 3/8/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import OCMixins

class GradientViewController: UIViewController, NavigationBarGradient {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarGradient(orientation: .horizontal, colors: [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.07843137255, green: 0.5333333333, blue: 0.6823529412, alpha: 1)])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeGradientFromNavigationBar()
    }
}
