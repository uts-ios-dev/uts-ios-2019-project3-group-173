//
//  PersonalVC.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/6/5.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class PersonalVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func udpate(_ sender: Any) {
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        performSegue(withIdentifier: "toLoginView1", sender: self)
    }
    
}
