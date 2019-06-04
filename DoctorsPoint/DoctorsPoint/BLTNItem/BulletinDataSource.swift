//
//  BLTNDataSource.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/28.
//  Copyright © 2019年 UTS. All rights reserved.
//

import BLTNBoard
import UIKit

enum BulletinDataSource {

    static func makePatientType() -> PatientTypeBLTN {
        
        let page = PatientTypeBLTN(title: "Make a Appointment")
//        page.image = UIImage(named: "...")
        
        page.descriptionText = "Who is this appointment for?"
        page.actionButtonTitle = "Continue"
        page.alternativeButtonTitle = "Not now"
        page.isDismissable = true
        return page
        
    }
    
    
    static func inputSomeElseName() -> SomeoneElseNameBLTN {

        let page = SomeoneElseNameBLTN(title: "Appointment for other")
//        page.image = UIImage(named: "...")
        page.descriptionText = "Please enter patient's name "
        page.actionButtonTitle = "Continue"
        page.alternativeButtonTitle = "Go back"
        page.isDismissable = true
        page.next = makeAppointmentType()

        page.actionHandler = { item in
            item.manager?.displayNextItem()
        }

        page.alternativeHandler = { item in
            item.manager?.popToRootItem()
        }

        return page
    }

    
    static func makeAppointmentType() -> AppointmentTypeBLTN {
        let page = AppointmentTypeBLTN(title: "Appointment Detail")
        //        page.image = UIImage(named: "...")
        page.descriptionText = "Select the appointment type"
        page.actionButtonTitle = "Continue"
        page.alternativeButtonTitle = "Go back"
        page.isDismissable = true
        return page
    }
    
    static func makeDateChoice() -> ChooseDateBLTN {
        
        let page = ChooseDateBLTN(title: "Choose a Date")
        page.descriptionText = "When do you wanna meet us"
        page.alternativeButtonTitle = "Go Back"
        page.actionButtonTitle = "Continue"
        
        page.isDismissable = true
        
        page.actionHandler = { item in
            print(page.datePicker.date)
            item.manager?.displayNextItem()
        }
        
        page.next = makeTimeChoice()
        
        return page

    }

    
    
    static func makeDoctorChoice() -> ChooseDoctorBLTN {
        
        let page = ChooseDoctorBLTN(title: "Your Prefer Doctor")
        page.descriptionText = "Choose a doctor below"
        page.actionButtonTitle = "Continue"
        page.alternativeButtonTitle = "Go Back"
        page.isDismissable = true
        return page
    }
    
    static func makeTimeChoice() -> ChooseTimeBLTN {
        
        let page = ChooseTimeBLTN(title: "Your Appointment Time")
        page.descriptionText = "When do you want to meet us?"
        page.alternativeButtonTitle = "Go Back"
        page.actionButtonTitle = "Continue"
                page.isDismissable = true
        return page
    }
    
    
    
}

