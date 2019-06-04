//
//  SignInVC.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 4/6/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    let myString = StringCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        if let email = emailTF.text
        {
            if let password = passwordTF.text
            {
                do{
                  Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    print(strongSelf)
                    // ...
                    self!.goToPactientMenu()
                    }
                }
            }
        }
        
    }
    
    
    func goToPactientMenu()
    {
        performSegue(withIdentifier: self.myString.fromSignIntoTabBar, sender: self)
    }
    
    
    
    
    
}
