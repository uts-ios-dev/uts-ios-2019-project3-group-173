//
//  ChooseDoctorBLTN.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/29.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import BLTNBoard
import UIKit
import FirebaseDatabase
import Firebase
import CollectionKit

class ChooseDoctorBLTN: BLTNPageItem {
    
    
    let myString = StringCollection()
    
    let selectionSuper = SelectionBLTNSuper()
    let collectionView = CollectionView()
    
    var arrangedSubViews: [UIView] = []
    var doctorList: [String] = []
    var currentIndex : Int = 0
    var previousIndex: Int = 0
    
    
    //another set  of data collection to init time
    var cloudTimeList: [String] = []
    var mondayTimetable: [String] = []
    var tuesdayTimetable: [String] = []
    var wednesdayTimetable: [String] = []
    var thursdayTimetable: [String] = []
    var fridayTimetable: [String] = []
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        doctorList = UserDefaults.standard.stringArray(forKey: self.myString.doctorList)!
        
        if doctorList.isEmpty
        {
            self.descriptionText = myString.makeAppointmentErrorMessage
            self.actionButtonTitle = nil
        }
        else
        {
            self.descriptionText = "Choose your perferred doctor"
            self.actionButtonTitle = "Finish"
            collectionView.contentInset = UIEdgeInsets(top: 60, left: 20, bottom: 10, right: 20)
            collectionView.contentInsetAdjustmentBehavior = .automatic
            
            let viewSource = ClosureViewSource(viewUpdater: { (view: UILabel, data: String, index: Int) in
                view.backgroundColor = UIColor(red: 232/255, green: 122/255, blue: 144/255, alpha: 1)
                view.text = "\(data)"
                view.textColor = .white
                view.textAlignment = .center
                view.font = .boldSystemFont(ofSize: 20)
            })
            
            collectionView.provider = BasicProvider(
                dataSource: doctorList,
                viewSource: viewSource,
                sizeSource: { (_, view, size) -> CGSize in
                    return CGSize(width: size.width, height: 50)
            },
                layout: FlowLayout(lineSpacing: 15,
                                   interitemSpacing: 15,
                                   justifyContent: .center,
                                   alignItems: .center,
                                   alignContent: .center),
                tapHandler: { [weak self] context in
                    self!.currentIndex = context.index
                    let currentSelectDoctor: String = (self?.doctorList[self!.currentIndex])!
                    UserDefaults.standard.set(currentSelectDoctor, forKey: self!.myString.currentSelectedDoctor)
                    print("Selected Doctor is " + UserDefaults.standard.string(forKey: self!.myString.currentSelectedDoctor)!)
                    self!.collectionView.cell(at: self!.previousIndex)?.backgroundColor? = UIColor(red: 232/255, green: 122/255, blue: 144/255, alpha: 1)
                    self!.collectionView.cell(at: self!.currentIndex)?.backgroundColor? = UIColor(red: 0/255, green: 111/255, blue: 255/255, alpha: 1)
                    self!.previousIndex = self!.currentIndex
                }
                
            )
            
            collectionView.animator = WobbleAnimator()
            arrangedSubViews.append(collectionView)
        }
        
        
        return arrangedSubViews
        
    }
    
    override func actionButtonTapped(sender: UIButton) {
    
        submitAppointmentRequest()
        next = BulletinDataSource.makeTimeChoice()
        self.manager?.dismissBulletin(animated: true)
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        doctorList.removeAll()
        manager?.popItem()
    }
    
    func submitAppointmentRequest()
    {
       
            let name = UserDefaults.standard.string(forKey: myString.currentPatientName)
            let phone = UserDefaults.standard.string(forKey: myString.currentPatientPhone)
            let doctor = UserDefaults.standard.string(forKey: myString.currentSelectedDoctor)
            let date = UserDefaults.standard.string(forKey: myString.currentSelectedDate)
            let time = UserDefaults.standard.string(forKey: myString.currentSelectedTime)
            let type = UserDefaults.standard.string(forKey: myString.currentAppoinmentType)
            let weekday = UserDefaults.standard.string(forKey: myString.currentSelectedWeekday)
            
            let appointment = [
                "name": name,
                "phone" : phone,
                
                "doctor": doctor,
                "date": date,
                "time": time
            ]
            
            print(appointment)
//        "name": name,
//        "phone" : phone,
//
//        "doctor": doctor,
//        "date": date,
//        "time": time
        
            
            DatabaseService(Auth.auth().currentUser!).appointmentReference?.childByAutoId().setValue(appointment)
        DatabaseService(Auth.auth().currentUser!).availabilityReference?.child(type!).child(weekday!).child(doctor!).child(time!).setValue(0)
            //todo set as a dictionary instead of an object
        }
    
}
