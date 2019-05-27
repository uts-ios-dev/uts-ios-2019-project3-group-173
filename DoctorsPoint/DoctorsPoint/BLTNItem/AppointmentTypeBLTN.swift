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

class AppointmentTypeBLTN: BLTNPageItem {
    
    
    var gpButton: UIButton?
    @objc var illnessButton: UIButton?
    @objc var otherButton: UIButton?
    
    let selectionSuper = SelectionBLTNSuper()
    
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
        
        next = PatientTypeBLTN()
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
    
        next = PatientTypeBLTN()
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
        
        next = PatientTypeBLTN()
    }
    
    override func actionButtonTapped(sender: UIButton) {
        manager?.displayNextItem()
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        manager?.popItem()
    }
    
}
