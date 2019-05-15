//
//  ViewController.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/15.
//  Copyright © 2019年 UTS. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    
    var ref: DatabaseReference!
    @IBOutlet weak var testDatabaseTF: UITextField!
    
    @IBOutlet weak var accountInfoLB: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ref = Database.database().reference()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        getUserInfo() //getting current signed-in user
    }


    @IBAction func updataDatabase(_ sender: Any) {
        
        let myText = testDatabaseTF.text!
        self.ref.child("testStringDatabase").setValue(myText)
        
    }
    
    
    func getUserInfo() {
        //currentUser would be nil if user havent login yet
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                
                print("user id is \(uid)") //debug
                print("email is \(String(describing: email))") //debug
                print("photoURL id is \(String(describing: photoURL))") //todo //debug
                
                accountInfoLB.text = "Account info: " + email! //debug
                
            }
        }
        else
        {
            // No user is signed in.
            // ...
        }
    }
    
    
    
    
}

