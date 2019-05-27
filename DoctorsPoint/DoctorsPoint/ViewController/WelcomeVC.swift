//
//  WelcomeVC.swift
//  DoctorsPoint
//
//  Created by Sakib on 28/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var topConstraintHeight: NSLayoutConstraint!
    @IBAction func ShowSignInPop(_ sender: Any) {
        topConstraintHeight.constant = 0
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        print("clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
