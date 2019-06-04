//
//  AppointmentTypeBLTN.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/27.
//  Copyright © 2019年 UTS. All rights reserved.
//


import UIKit
import BLTNBoard

class PatientTypeBLTN: BLTNPageItem {
    
    let myString = StringCollection()

    var mySelfButton: UIButton?
    var someoneElseButton: UIButton?
    
    let selectionSuper = SelectionBLTNSuper()

    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        let patientTypeStack = interfaceBuilder.makeGroupStack(spacing: 16)
        
        mySelfButton = selectionSuper.cunstomedButtonCell(myString.myself, true)
        mySelfButton!.addTarget(self, action: #selector(mySelfButtonTapped), for: .touchUpInside)
        patientTypeStack.addArrangedSubview(mySelfButton!)
        
    
        
        someoneElseButton = selectionSuper.cunstomedButtonCell(myString.someoneElse, false)
        someoneElseButton!.addTarget(self, action: #selector(someoneElseButtonTapped), for: .touchUpInside)
        patientTypeStack.addArrangedSubview(someoneElseButton!)
        
        return [patientTypeStack]
        
    }
    
    @objc func mySelfButtonTapped() {
        
        //update UI
        let mySelfCoulour = appearance.actionButtonColor
        mySelfButton?.layer.borderColor = mySelfCoulour.cgColor
        mySelfButton?.setTitleColor(mySelfCoulour, for: .normal)
        mySelfButton?.accessibilityTraits.insert(.selected)
        
        let someElseColour = UIColor.lightGray
        someoneElseButton?.layer.borderColor = someElseColour.cgColor
        someoneElseButton?.setTitleColor(someElseColour, for: .normal)
        someoneElseButton?.accessibilityTraits.remove(.selected)
        
        next = BulletinDataSource.makeAppointmentType()
    }
        
    
    @objc func someoneElseButtonTapped() {

        //update UI
        let mySelfCoulour = UIColor.lightGray
        mySelfButton?.layer.borderColor = mySelfCoulour.cgColor
        mySelfButton?.setTitleColor(mySelfCoulour, for: .normal)
        mySelfButton?.accessibilityTraits.remove(.selected)
        
        let someElseColour = appearance.actionButtonColor
        someoneElseButton?.layer.borderColor = someElseColour.cgColor
        someoneElseButton?.setTitleColor(someElseColour, for: .normal)
        someoneElseButton?.accessibilityTraits.insert(.selected)
        
            next = BulletinDataSource.inputSomeElseName()
    }
    
    override func actionButtonTapped(sender: UIButton) {
        if next == nil
        {
            next = BulletinDataSource.makeAppointmentType()
        }
        manager?.displayNextItem()
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        manager?.dismissBulletin()
    }
    }
