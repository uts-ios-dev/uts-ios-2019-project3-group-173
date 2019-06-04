//
//  UpdatePersonalVC.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/6/5.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

class UpdatePersonalVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var accessLevel: UITextField!
    
    let myString = StringCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func udpateInformation(_ sender: Any) {
        
        let name = nameTF.text!
        let phone = phoneTF.text!
        let level = accessLevel.text!
        
        if name != "" && phone != "" && level != ""
        {
            DatabaseService.init(Auth.auth().currentUser!).userReference?.child("name").setValue(name)
            DatabaseService.init(Auth.auth().currentUser!).userReference?.child("phone").setValue(phone)
            DatabaseService.init(Auth.auth().currentUser!).userReference?.child("level").setValue(level)
            performSegue(withIdentifier: myString.fromUpdatetoPMenu, sender: self)
        }
        else
        {
            
            let alert = UIAlertController(title: "Error", message: "Please ensure all detail have been added and correct", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
}
