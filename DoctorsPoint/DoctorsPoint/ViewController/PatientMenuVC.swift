//
//  PatientMenuVC.swift
//  
//
//  Created by Jiajian Liang on 2019/5/16.
//

import UIKit
import Firebase

class PatientMenuVC: UIViewController {
    
    let myString = StringCollection()
    let user: User? = nil
    
    
    @IBOutlet weak var accountInfoLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkCurrentUser()
    }
    
    
    func checkCurrentUser()
    {
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
                print("email is \(String(describing: email!))") //debug
                print("photoURL id is \(String(describing: photoURL!))") //todo //debug
                
                accountInfoLB.text = email
            }
        }
        else
        {
            print("No current login user")
            performSegue(withIdentifier: myString.toLoginView, sender: self)
            // ...
        }
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: myString.toLoginView, sender: self )
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        
    }
}
    
    
    

