//
//  ViewController.swift
//  OCMixins
//
//  Created by Henrique Morbin on 08/08/2016.
//  Copyright (c) 2016 Henrique Morbin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ModalViewController {
            destination.applyTransparentBackground()
        }
    }

}

