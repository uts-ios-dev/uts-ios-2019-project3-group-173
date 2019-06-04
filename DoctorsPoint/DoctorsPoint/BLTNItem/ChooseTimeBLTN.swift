//
//  ChooseTimeBLTN.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/30.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import BLTNBoard
import CollectionKit
import Firebase

class ChooseTimeBLTN: BLTNPageItem {
    
    let myString = StringCollection()
    lazy var timePicker = UIDatePicker()
    var doctorList: [String] = []
    
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {

        timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let min = dateFormatter.date(from: "9:00")      //createing min time
        let max = dateFormatter.date(from: "18:00") //creating max time
        timePicker.locale =  NSLocale(localeIdentifier: "en_GB") as Locale
        timePicker.minimumDate = min
        timePicker.maximumDate = max
        
        
        return [timePicker]
    }
    
    @objc func timeChanged()
    {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "HH:mm"
        let time = dateFormatter.string(from: timePicker.date)
        UserDefaults.standard.set(time, forKey: myString.currentSelectedTime)
        
        
        let type = UserDefaults.standard.string(forKey: myString.currentAppoinmentType)!
        let weekday = UserDefaults.standard.string(forKey: myString.currentSelectedWeekday)!
        
        let ref = Database.database().reference().child(myString.availability).child(type).child(weekday)
        ref.queryOrdered(byChild: time).queryEqual(toValue: 1)
            .observeSingleEvent(of: .value, with: { snap in
                for snap in snap.children.allObjects as! [DataSnapshot]
                {
                    print(snap.key)
                }
            })
        
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        manager?.popItem()
    }
    
    
    

    override func actionButtonTapped(sender: UIButton) {
        
        let delayForDisplay = DispatchTime.now() + .seconds(4)
        prepareDataforDoctorBLTN()
        
        DispatchQueue.main.asyncAfter(deadline: delayForDisplay) {
            UserDefaults.standard.set(self.doctorList, forKey: self.myString.doctorList)
            if self.next == nil
            {
                self.next = BulletinDataSource.makeDoctorChoice()
            }
            self.manager?.displayNextItem()
        }
    }

    
    func prepareDataforDoctorBLTN() {
        
        doctorList.removeAll()
        UserDefaults.standard.removeObject(forKey: myString.doctorList)
        
        let type = UserDefaults.standard.string(forKey: myString.currentAppoinmentType)!
        let weekday = UserDefaults.standard.string(forKey: myString.currentSelectedWeekday)!
        let time = UserDefaults.standard.string(forKey: myString.currentSelectedTime)!
        print("\n\n\n")
        print(type)
        print(weekday)
        print(time)
        print("\n\n\n")
        
        
        
        let ref = Database.database().reference().child(myString.availability).child(type).child(weekday)
        ref.queryOrdered(byChild: time).queryEqual(toValue: 1)
            .observeSingleEvent(of: .value, with: { snap in
                for snap in snap.children.allObjects as! [DataSnapshot]
                {
                    print(snap.key)
                    self.doctorList.append(snap.key)
                }
            })
        
    }
    
}
