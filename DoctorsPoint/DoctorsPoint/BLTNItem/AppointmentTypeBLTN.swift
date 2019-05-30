//
//  AppointmentTypeBLTN.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/28.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import BLTNBoard
import UIKit
import FirebaseAuth
import FirebaseDatabase

class AppointmentTypeBLTN: BLTNPageItem {
    
    @objc var gpButton: UIButton?
    @objc var illnessButton: UIButton?
    @objc var otherButton: UIButton?
    let myString = StringCollection()
    let selectionSuper = SelectionBLTNSuper()
    var cloudDoctorList: [String] = []
    
    

    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        let appointmentTypeStack = interfaceBuilder.makeGroupStack(spacing: 16)
        
        
        gpButton = selectionSuper.cunstomedButtonCell("GP", true)
        gpButton!.addTarget(self, action: #selector(gpButtonTapped), for: .touchUpInside)
        appointmentTypeStack.addArrangedSubview(gpButton!)
        
        illnessButton = selectionSuper.cunstomedButtonCell("Illness", false)
        illnessButton!.addTarget(self, action: #selector(illnessButtonTapped), for: .touchUpInside)
        appointmentTypeStack.addArrangedSubview(illnessButton!)
        
        otherButton = selectionSuper.cunstomedButtonCell("Other", false)
        otherButton!.addTarget(self, action: #selector(otherButtonTapped), for: .touchUpInside)
        appointmentTypeStack.addArrangedSubview(otherButton!)
        
        return [appointmentTypeStack]
        
    }
    
    @objc func gpButtonTapped() {
        
        //update UI
        let gpColour = appearance.actionButtonColor
        gpButton?.layer.borderColor = gpColour.cgColor
        gpButton?.setTitleColor(gpColour, for: .normal)
        gpButton?.accessibilityTraits.insert(.selected)
        
        let unselectedColour = UIColor.lightGray
        illnessButton?.layer.borderColor = unselectedColour.cgColor
        illnessButton?.setTitleColor(unselectedColour, for: .normal)
        illnessButton?.accessibilityTraits.remove(.selected)
        otherButton?.layer.borderColor = unselectedColour.cgColor
        otherButton?.setTitleColor(unselectedColour, for: .normal)
        otherButton?.accessibilityTraits.remove(.selected)
        
        UserDefaults.standard.set(self.myString.gp, forKey: self.myString.currentAppoinmentType)
        printCurrentType()
        next = BulletinDataSource.makeDoctorChoice()
    }
    
    @objc func illnessButtonTapped() {
        
        //update UI
        let illnessColour = appearance.actionButtonColor
        illnessButton?.layer.borderColor = illnessColour.cgColor
        illnessButton?.setTitleColor(illnessColour, for: .normal)
        illnessButton?.accessibilityTraits.insert(.selected)
        
        let unselectedColour = UIColor.lightGray
        gpButton?.layer.borderColor = unselectedColour.cgColor
        gpButton?.setTitleColor(unselectedColour, for: .normal)
        gpButton?.accessibilityTraits.remove(.selected)
        otherButton?.layer.borderColor = unselectedColour.cgColor
        otherButton?.setTitleColor(unselectedColour, for: .normal)
        otherButton?.accessibilityTraits.remove(.selected)
        
        UserDefaults.standard.set(self.myString.illness, forKey: self.myString.currentAppoinmentType)
        printCurrentType()
        next = BulletinDataSource.makeDoctorChoice()
    }
    
    @objc func otherButtonTapped() {
        
        //update UI
        let otherColour = appearance.actionButtonColor
        otherButton?.layer.borderColor = otherColour.cgColor
        otherButton?.setTitleColor(otherColour, for: .normal)
        otherButton?.accessibilityTraits.insert(.selected)
        
        let unselectedColour = UIColor.lightGray
        gpButton?.layer.borderColor = unselectedColour.cgColor
        gpButton?.setTitleColor(unselectedColour, for: .normal)
        gpButton?.accessibilityTraits.remove(.selected)
        illnessButton?.layer.borderColor = unselectedColour.cgColor
        illnessButton?.setTitleColor(unselectedColour, for: .normal)
        illnessButton?.accessibilityTraits.remove(.selected)
        
        UserDefaults.standard.set(self.myString.other, forKey: self.myString.currentAppoinmentType)
        printCurrentType()
        next = BulletinDataSource.makeDoctorChoice()
    }
    
    override func actionButtonTapped(sender: UIButton) {
        
        manager?.displayActivityIndicator()
        
        
        let delayForDisplay = DispatchTime.now() + .seconds(4)
        prepareDataForNextItem()
        
        DispatchQueue.main.asyncAfter(deadline: delayForDisplay) {
            if self.next == nil
            {
                UserDefaults.standard.set(self.myString.gp, forKey: self.myString.currentAppoinmentType)
                self.printCurrentType()
                self.next = BulletinDataSource.makeDoctorChoice()
            }
            self.manager?.displayNextItem()
        }
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        manager?.popItem()
    }
    
    
    func prepareDataForNextItem()
    {
        cloudDoctorList.removeAll()
        DatabaseService(Auth.auth().currentUser!).doctorReference!.observe(.value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                self.cloudDoctorList.append(snap.key)
            }
        }) //get doctorlist from firebase
        
        let delayForData = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: delayForData)
        {
            print(self.cloudDoctorList)
            UserDefaults.standard.set(self.cloudDoctorList, forKey: self.myString.doctorList)
            print(UserDefaults.standard.stringArray(forKey: self.myString.doctorList)!)
        }
    }
    
    func printCurrentType()
    {
        print("Appointment Tpye is " + UserDefaults.standard.string(forKey: myString.currentAppoinmentType)!)
    }
    
    
   
}
