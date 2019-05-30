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
import CollectionKit


class ViewAppointmentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var appointmentTBV: UITableView!
    
    let viewer = Auth.auth().currentUser
    var userAppointment = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DatabaseService(viewer!).appointmentReference?.observe(DataEventType.value, with: { (snapshot) in
            print(snapshot)
            guard let appointmentList = AppointmentFirebaseSnapshot(snapshot) else {return}
            self.userAppointment = appointmentList.appointments
            self.userAppointment.sort(by: { $0.date.compare($1.date) == .orderedDescending })
            self.appointmentTBV.reloadData()
        }) //getting appointment database according to current user logined -- in JSON
            
        
        appointmentTBV.delegate = self
        appointmentTBV.dataSource = self
        appointmentTBV.reloadData()
        

        
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = appointmentTBV.dequeueReusableCell(withIdentifier: "reuseAppointmentCell", for: indexPath)
        
        let nameLabel: UILabel = cell.viewWithTag(1) as! UILabel
        let doctorLabel: UILabel = cell.viewWithTag(2) as! UILabel
        
        nameLabel.text = userAppointment[indexPath.row].firstName + userAppointment[indexPath.row].lastName
        doctorLabel.text = userAppointment[indexPath.row].doctor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAppointment.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = UIColor.red

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        label.textColor = .white
        label.text = "Appointment"
        label.textAlignment = .center
        returnedView.addSubview(label)

        return returnedView


    }
}

