//
//  ViewController.swift
//  TestLayout
//
//  Created by VAndrJ on 3/11/18.
//  Copyright © 2018 VAndrJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let animationDuration: TimeInterval = 0.5

    @IBOutlet weak var testView: TestView! {
        didSet {
            testView.multiplier = 0
            testView.alpha = 0
            testView.animationDuration = animationDuration
        }
    }

    // MARK: - Demo. Split and use.

    @IBAction func closeAction(_ sender: UIButton) {
        testView.multiplier = 0
        UIView.animate(withDuration: animationDuration, delay: animationDuration, options: .curveEaseInOut, animations: {
            self.testView.alpha = 0
        }, completion: nil)
    }

    @IBAction func openAction(_ sender: UIButton) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.testView.alpha = 1
        }, completion: { _ in
            self.testView.multiplier = 1
        })
    }
}

