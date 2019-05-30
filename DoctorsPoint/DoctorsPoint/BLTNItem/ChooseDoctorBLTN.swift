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
            self.actionButtonTitle = "Continue"
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
        
        let delayForDisplay = DispatchTime.now() + .seconds(4)
        prepareDataForAppointmentTimeItem()
        next = BulletinDataSource.makeTimeChoice()
        DispatchQueue.main.asyncAfter(deadline: delayForDisplay) {
            
            self.manager?.displayNextItem()
        }
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        doctorList.removeAll()
        manager?.popItem()
    }
    
    func prepareDataForAppointmentTimeItem()
    {
        eraseTempData()
        
        let selectedDoctor = UserDefaults.standard.string(forKey: myString.currentSelectedDoctor)
        DatabaseService(Auth.auth().currentUser!).doctorReference!.child(selectedDoctor!).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let available = snap.value as! Int
                if available == 1
                {
                    self.filiterWeekday(snap.key)
                }
            }
        }) //get doctorlist from firebase
        
        let delayForData = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: delayForData)
        {
            self.printTimetable()
            self.saveTempTimetabletoDatabase()
            
        }
    }
    
    
    func filiterWeekday(_ time: String)
    {
        switch time {
        case "109":
            mondayTimetable.append("09:00")
            break
        case "112":
            mondayTimetable.append("12:00")
            break
        case "115":
            mondayTimetable.append("15:00")
            break
        case "209":
            tuesdayTimetable.append("09:00")
            break
        case "212":
            tuesdayTimetable.append("12:00")
            break
        case "215":
            tuesdayTimetable.append("15:00")
            break
        case "309":
            wednesdayTimetable.append("09:00")
            break
        case "312":
            wednesdayTimetable.append("12:00")
            break
        case "315":
            wednesdayTimetable.append("15:00")
            break
        case "409":
            thursdayTimetable.append("09:00")
            break
        case "412":
            thursdayTimetable.append("12:00")
            break
        case "415":
            thursdayTimetable.append("15:00")
            break
        case "509":
            fridayTimetable.append("09:00")
            break
        case "512":
            fridayTimetable.append("12:00")
            break
        case "515":
            fridayTimetable.append("15:00")
            break
        default:
            break
        }
    }
    
    func printTimetable()
    {
        print("Monday is \(mondayTimetable)")
        print("Tuesday is \(tuesdayTimetable)")
        print("Wednesday is \(wednesdayTimetable)")
        print("Thursday is \(thursdayTimetable)")
        print("Friday is \(fridayTimetable)")
    }
    
    func saveTempTimetabletoDatabase()
    {
        UserDefaults.standard.set(mondayTimetable, forKey: myString.mondayTimetable)
        UserDefaults.standard.set(tuesdayTimetable, forKey: myString.tuesdayTimetable)
        UserDefaults.standard.set(wednesdayTimetable, forKey: myString.wednesdayTimetable)
        UserDefaults.standard.set(thursdayTimetable, forKey: myString.thursdayTimetable)
        UserDefaults.standard.set(fridayTimetable, forKey: myString.fridayTimetable)
    }
    

    func eraseTempData()
    {
        cloudTimeList.removeAll()
        mondayTimetable.removeAll()
        tuesdayTimetable.removeAll()
        wednesdayTimetable.removeAll()
        thursdayTimetable.removeAll()
        fridayTimetable.removeAll()
        
        
    }
}
