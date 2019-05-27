//
//  registrationBLTN.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/27.
//  Copyright © 2019年 UTS. All rights reserved.
//


import UIKit
import BLTNBoard

class SomeoneElseNameBLTN: BLTNPageItem {
    
    
    var nameTF: UITextField!
    
    var textInputHandler: ((BLTNActionItem, String?) -> Void)? = nil
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        nameTF = interfaceBuilder.makeTextField(placeholder: "First Name and Last Name", returnKey: .done, delegate: self)
        return [nameTF]
    }
    

    
    override func tearDown() {
        super.tearDown()
        nameTF?.delegate = nil
    }
    
    override func actionButtonTapped(sender: UIButton) {
        nameTF.resignFirstResponder()
        super.actionButtonTapped(sender: sender)
    }
    
}
    extension SomeoneElseNameBLTN: UITextFieldDelegate {
        
        @objc open func isInputValid(text: String?) -> Bool {
            
            if text == nil || text!.isEmpty {
                return false
            }
            
            return true
            
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            nameTF.resignFirstResponder()
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if isInputValid(text: textField.text) {
                textInputHandler?(self, textField.text)
            } else {
                descriptionLabel!.textColor = .red
                descriptionLabel!.text = "Please enter patient's name to continue"
                nameTF.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            }
            
        }
}
