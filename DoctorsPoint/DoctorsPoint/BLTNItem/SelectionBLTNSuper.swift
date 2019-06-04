//
//  SelectionSuper.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/28.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import BLTNBoard

class SelectionBLTNSuper: BLTNPageItem {
    
    func cunstomedButtonCell(_ patientType: String, _ isSelected: Bool) -> UIButton
    {
        
        let customedButton = UIButton(type: .system)
        customedButton.setTitle(patientType, for: .normal)
        customedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        customedButton.contentHorizontalAlignment = .center
        customedButton.accessibilityLabel = patientType
        
        if isSelected {
            customedButton.accessibilityTraits.insert(.selected)
        } else {
            customedButton.accessibilityTraits.remove(.selected)
        }
        
        customedButton.layer.cornerRadius = 12
        customedButton.layer.borderWidth = 2
        
        let heightConstraint = customedButton.heightAnchor.constraint(equalToConstant: 55)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
        
        let buttonColor = isSelected ? appearance.actionButtonColor : .lightGray
        customedButton.layer.borderColor = buttonColor.cgColor
        customedButton.setTitleColor(buttonColor, for: .normal)
        customedButton.layer.borderColor = buttonColor.cgColor
        
        return customedButton
    }
    
    
}
