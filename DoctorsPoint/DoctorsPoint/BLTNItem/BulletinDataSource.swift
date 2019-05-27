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
        
//        page.shouldStartWithActivityIndicator = true
//        page.presentationHandler = { item in
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
//                item.manager?.hideActivityIndicator()
//            }
//
//        }
        return page
        
    }
    
    
    static func inputSomeElseName() -> SomeoneElseNameBLTN {

        let page = SomeoneElseNameBLTN(title: "Appointment for other")
//        page.image = UIImage(named: "...")
        page.descriptionText = "Please enter patient's name "
        page.actionButtonTitle = "Continue"
        page.alternativeButtonTitle = "Go back"

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

        return page
    }
    
    
}

