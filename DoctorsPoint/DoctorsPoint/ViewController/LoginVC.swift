//
//  ViewController.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/15.
//  Copyright © 2019年 UTS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController{

    let myString = StringCollection()

   
    @IBOutlet weak var topConstraintHeight: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.


       topConstraintHeight.constant = 800
  
        
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    @IBAction func ShowSignInPop(_ sender: Any) {
        topConstraintHeight.constant = 100
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseOut, animations: {self.view.layoutIfNeeded()}, completion: nil)
        print("clicked")
    }
    
    
    
    func goToPatientMenu() {
        performSegue(withIdentifier: myString.toPatientMainView, sender: self)
    }
    
    func goToDoctorMenu() {
        performSegue(withIdentifier: myString.toDoctorMainView, sender: self)
    }
    
}

