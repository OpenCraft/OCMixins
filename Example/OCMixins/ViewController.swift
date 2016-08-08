//
//  ViewController.swift
//  OCMixins
//
//  Created by Henrique Morbin on 08/08/2016.
//  Copyright (c) 2016 Henrique Morbin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? ModalViewController {
            destination.applyTransparentBackground()
        }
    }

}

