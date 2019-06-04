//
//  PatientMenuVC.swift
//  
//
//  Created by Jiajian Liang on 2019/5/16.
//

import UIKit
import Firebase
import FirebaseAuth
import BLTNBoard
import FirebaseDatabase

class PatientMenuVC: UIViewController {
    
    let myString = StringCollection()
    let user: User? = nil
    
    lazy var bulletinManager: BLTNItemManager = {
        let introPage = BulletinDataSource.makePatientType()
        return BLTNItemManager(rootItem: introPage)
    }()
    
    
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var accountInfoLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPhoto.layer.cornerRadius = userPhoto.frame.height / 2
        userPhoto.clipsToBounds = true

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkCurrentUser()
    }
    
    
    @IBAction func makeAppointmentTapped(_ sender: Any) {
    
         bulletinManager.showBulletin(above: self)
        
        
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
                
                DatabaseService(user).userReference?.observe(.value, with: { (snapshot) in
                                        print(snapshot)
                })

                
                let myUrl = URL.init(string: "https://lh3.googleusercontent.com/a-/AAuE7mAL5KcZ16BY8OZwtfvIagZjmUhNvgp8RvAYQX8Yfg=s96")
                let data = try? Data(contentsOf: myUrl!)
                userPhoto.image = UIImage(data: data!)
//                let photoURL = user.photoURL
                
                print("user id is \(uid)") //debug
                print("email is \(String(describing: user.email!))") //debug
//                print("photoURL id is \(String(describing: photoURL!))") //todo //debug
                
                DatabaseService(user).userReference?.child("name").observeSingleEvent(of: .value, with: { (snapshot) in
                    print(snapshot)
                    let name = snapshot.value
                    self.accountInfoLB.text = (name as! String)
                    UserDefaults.standard.set(name, forKey: self.myString.currentPatientName)
                })
                
                DatabaseService(user).userReference?.child("phone").observeSingleEvent(of: .value, with: { (snapshot) in
                    print(snapshot)
                    let phone = snapshot.value
                    UserDefaults.standard.set(phone, forKey: self.myString.currentPatientPhone)
                })
                

            }
        }
        else
        {
            print("No current login user")
//            performSegue(withIdentifier: myString.toLoginView, sender: self)
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
    
    
    

