//
//  DoctorMenuVC.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/16.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import CollectionKit

class DoctorMenuVC: UIViewController {
    
    @IBOutlet weak var doctorName: UITextField!
    @IBOutlet weak var accountInfoLB: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    let myString = StringCollection()
    
    let doctor = Auth.auth().currentUser!
    var doctorAvail = [DoctorAvailability]()
    
    
    let collectionView = CollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    @IBAction func createDoctor(_ sender: Any) {
        
        let name = doctorName.text!
        initAvailability(name)
        getDoctorList()
    }
    
    
    func initAvailability(_ name: String)
    {
//        let weekdays = ["1", "2", "3", "4", "5"]
        //        let times = ["09:00", "12:00", "15:00"]
        let available = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
            {
                
                let availability = [
                    "109" : available,
                    "112" : available,
                    "115" : available,
                    
                    "209" : available,
                    "212" : available,
                    "215" : available,
                    
                    "309" : available,
                    "312" : available,
                    "315" : available,
                    
                    "409" : available,
                    "412" : available,
                    "415" : available,
                    
                    "509" : available,
                    "512" : available,
                    "515" : available,
                    ]
                DatabaseService(self.doctor).doctorReference!.child(name).setValue(availability)
            }
        getAvailability(name)
    }
    
    
    func getAvailability(_ name: String) {
        
        DatabaseService(doctor).doctorReference?.child(name).observe(DataEventType.value, with: { (snapshot) in
            guard let currentAvail = AvailabilitySnapshot(snapshot) else {return}
            self.doctorAvail = currentAvail.totalAvailability
        }) //getting appointment database according to current user logined -- in JSON
        
        
    }
    
    func getDoctorList()
    {
        DatabaseService(doctor).doctorReference?.observe(.childAdded, with: { (snapshot) in
            let dict = snapshot.key as String
            print(type(of: dict))
        })
    }
}
