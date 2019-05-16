//
//  Appointment.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/16.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation

struct Appointment {
    
    let appointmentId: String
    let firstName: String
    let lastName: String
    let phone: String
    
    let doctor: String
    let date: String
    let time: String
    
    init?(_ appointmentId: String, _ dict: [String: Any]) {
    
        self.appointmentId = appointmentId
        
        guard
            let firstName = dict["firstName"] as? String,
            let lastName = dict["lastName"] as? String,
            let phone = dict["phone"] as? String,
            let doctor = dict["doctor"] as? String,
            
            let date = dict["date"] as? String,
            let time = dict["time"] as? String
            else{return nil}
        
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        
        self.doctor = doctor
        self.date = date
        self.time = time
        
        
    }
    
    
    
}
