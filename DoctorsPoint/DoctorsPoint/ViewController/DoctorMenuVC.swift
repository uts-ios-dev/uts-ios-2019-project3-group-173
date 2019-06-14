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

class DoctorMenuVC: UIViewController{
    
    @IBOutlet weak var doctorName: UITextField!
    @IBOutlet weak var typeTF: UITextField!
    
    let myString = StringCollection()
    
    let doctor = Auth.auth().currentUser!
    var doctorAvail = [DoctorAvailability]()
    var doctorType: String = "gp"
    
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
    
    /*
     create availability for a doctor
     */
    func initAvailability(_ name: String)
    {
        if typeTF.text != nil
        {
            doctorType = typeTF.text!
        }
        let available = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            for day in self.myString.weekdays
            {
                for workingTime in self.myString.workingTime
                {
                    DatabaseService(self.doctor).availabilityReference!.child(self.doctorType).child(day).child(name).child(workingTime).setValue(available)
                }
            }
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
