//
//  WelcomeVC.swift
//  DoctorsPoint
//
//  Created by Sakib on 28/5/19.
//  Copyright © 2019 UTS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase


class SignUpVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var beDoctor: UIButton!
    @IBOutlet weak var bePatient: UIButton!
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    

    var level: Int = 0
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    let myString = StringCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bePatient.isHidden = true
        bePatient.isEnabled = false
    }
    
    func addAccountInformationToDB(_ user: User, _ name: String, _ phone: String)
    {
        
//        let uid: String
//        let name: String
//        let email: String
//        let photoUrl: URL
//        let level: Int

        
        
        let imageUrl = myString.imageUrl
        let uid = user.uid
        let email = user.email
        let photoUrl = imageUrl
        let level = self.level
        
        let myUser = [
            "uid": uid,
            "name": name,
            "email": email!,
            "photoUrl": photoUrl,
            "phone": phone,
            "level": level
            ] as [String : Any]
        
        


        DatabaseService(user).userReference?.setValue(myUser)
        
        
        
    }
    
    
    @IBAction func signUpAccount(_ sender: Any) {
        
        if isVaildate()
        {
            let email = emailTF.text!
            let password = passwordTF.text!
            let name = nameTF.text!
            let phone = phoneTF.text!
        
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                // ...
                guard let user = authResult?.user else { return }
                
                print(user)
                self.addAccountInformationToDB(user, name, phone)
                self.showMenu(self.level)
            }
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Please ensure all detail have been added and correct", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showMenu(_ menuID: Int)
    {
        if menuID == 0
        {
            performSegue(withIdentifier: "fromSignUptoPMenu", sender: self)
        }
        else if menuID == 1
        {
            performSegue(withIdentifier: self.myString.fromSignuptoDView, sender: self)
        }
    }
    
    
    
    @IBAction func beDoctorTapped(_ sender: Any) {
        
        level = 1
        bePatient.isEnabled = true
        bePatient.isHidden = false
        beDoctor.isEnabled = false
        beDoctor.isHidden = true
        
    }
    
    
    
    @IBAction func bePatientTapped(_ sender: Any) {
        level = 0
        bePatient.isHidden = true
        bePatient.isEnabled = false
        beDoctor.isHidden = false
        beDoctor.isEnabled = true
    }
    
    
    func isVaildate() -> Bool {

        email = emailTF.text!
        password = passwordTF.text!

        if isValidEmail(testStr: email) && password != ""
        {
            return true
        }
        return false

    }


    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }


}
