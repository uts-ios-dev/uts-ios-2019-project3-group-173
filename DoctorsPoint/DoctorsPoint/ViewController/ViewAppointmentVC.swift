//
//  ViewAppointmentVC.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/20.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import ViewAnimator

class ViewAppointmentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private let animations = [AnimationType.from(direction: .left, offset: 60.0)]
    

    
    @IBOutlet weak var appointmentTBV: UITableView!
    
    var userAppointment = [Appointment]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseService(Auth.auth().currentUser!).appointmentReference?.observe(DataEventType.value, with: { (snapshot) in
            print(snapshot)
            guard let appointmentList = AppointmentFirebaseSnapshot(snapshot) else {return}
            print(appointmentList)
            self.userAppointment = appointmentList.appointments
            self.userAppointment.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            self.appointmentTBV.reloadData()
        }) //getting appointment database according to current user logined -- in JSON
        
    
        
        appointmentTBV.delegate = self
        appointmentTBV.dataSource = self
        appointmentTBV.reloadData()
        
        

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.animate(animations: animations)
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = appointmentTBV.dequeueReusableCell(withIdentifier: "reuseAppointmentCell", for: indexPath)
        
        let nameLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let doctorLabel: UILabel = cell.viewWithTag(2) as! UILabel
        let phoneLabel: UILabel = cell.viewWithTag(3) as! UILabel
        let timeLabel: UILabel = cell.viewWithTag(4) as! UILabel
        
        
        nameLabel.text = userAppointment[indexPath.row].name
        let doctor = "Dr. " + userAppointment[indexPath.row].doctor
        doctorLabel.text = doctor
        phoneLabel.text = userAppointment[indexPath.row].phone
        let myTime = userAppointment[indexPath.row].date + " " + userAppointment[indexPath.row].time
        timeLabel.text = myTime
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAppointment.count
    }
    
    
    
}

