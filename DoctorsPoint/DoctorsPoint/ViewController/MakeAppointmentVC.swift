//
//  MakeAppointmentVC.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/16.
//  Copyright © 2019年 UTS. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import BLTNBoard
import FirebaseAuth

class MakeAppointmentVC: UIViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var doctorTF: UITextField!
    private var datePicker: UIDatePicker?
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    let myString = StringCollection()
    let patient = Auth.auth().currentUser
    var ref: DatabaseReference!

    
    lazy var bulletinManager: BLTNItemManager = {
        let introPage = BulletinDataSource.makePatientType()
        return BLTNItemManager(rootItem: introPage)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(MakeAppointmentVC.dateChanged(datePicker:)), for: .valueChanged)
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 7, to: Date())
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(MakeAppointmentVC.timechanged(timePicker:)), for: .valueChanged)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let min = dateFormatter.date(from: "9:00")      //createing min time
        let max = dateFormatter.date(from: "18:00") //creating max time
        timePicker.locale =  NSLocale(localeIdentifier: "en_GB") as Locale
        timePicker.minimumDate = min
        timePicker.maximumDate = max

        
        
        dateTF.inputView = datePicker
        timeTF.inputView = timePicker

        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(MakeAppointmentVC.dismissDatePicker(gestureRecongnizer:)))
//        view.addGestureRecognizer(tap)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        bulletinManager.showBulletin(above: self)
    }
    
    
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        dateTF.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func timechanged(timePicker: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        timeTF.text = timeFormatter.string(from: timePicker.date)
    }
    
//    @objc func dismissDatePicker(gestureRecongnizer: UIDatePicker) {
//        view.endEditing(true)
//    }
    

    
    
    @IBAction func submitAppointment(_ sender: Any) {
        //todo should check user input
//        let name = nameTF.text!
//        let phone = phoneTF.text!
//        
//        let doctor = doctorTF.text!
//        let date = dateTF.text!
//        let time = timeTF.text!
//        
//        
//        let appointment = [
//            "name": name
//            "phone" : phone,
//            
//            "doctor": doctor,
//            "date": date,
//            "time": time
//        ]
//        
//        
////        let appointmentId: String
////        let firstName: String
////        let lastName: String
////        let phone: String
////
////        let doctor: String
////        let date: String
////        let time: String
//        
//        
//        DatabaseService(patient!).appointmentReference?.childByAutoId().setValue(appointment)
        
        //todo set as a dictionary instead of an object
    }
    
    

    
    
    
    
    
    
    
    
    
    
}
