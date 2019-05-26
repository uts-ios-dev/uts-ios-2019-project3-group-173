//
//  ViewController.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/15.
//  Copyright © 2019年 UTS. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let myString = StringCollection()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }

    override func viewDidAppear(_ animated: Bool) {
            checkLogined()
    }
    
    
    func checkLogined() {
        if Auth.auth().currentUser != nil
        {
            print("Current User valid \(Auth.auth().currentUser!.uid)")
            goToPatientMenu()
        }
        else
        {
            print("No Current User")
        }
        
    }
    
    
    
    func goToPatientMenu() {
        performSegue(withIdentifier: myString.toPatientMainView, sender: self)
    }
    
    func goToDoctorMenu() {
        performSegue(withIdentifier: myString.toDoctorMainView, sender: self)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        
        guard let email = emailTF.text,
            email != "",
            let password = passwordTF.text,
            password != ""
            else {//show invalidte message
                return
        }
    
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            guard error == nil else {
                // show login fail
                return
            }
            
            guard let user = user else { return }
            
            
            
            
            
            
        }
    }
    
}

