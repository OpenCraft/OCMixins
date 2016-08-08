//
//  ModalViewController.swift
//  OCMixins
//
//  Created by Henrique Morbin on 08/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import OCMixins

class ModalViewController: UIViewController, TransparentModal {

    @IBAction func dismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
