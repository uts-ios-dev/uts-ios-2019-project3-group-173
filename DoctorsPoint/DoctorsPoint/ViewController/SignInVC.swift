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
                        if error != nil
                        {
                            self?.handleError(error!)
                        }
                        guard let strongSelf = self
                            else
                        {
                            return
                        }
                        print(strongSelf)
                        // ...
                        if user != nil
                        {
                            self!.goToPactientMenu()
                        }
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

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect."
        default:
            return "Unknown error occurred"
        }
    }
}


extension UIViewController {
    func handleError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Error", message: errorCode.errorMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
