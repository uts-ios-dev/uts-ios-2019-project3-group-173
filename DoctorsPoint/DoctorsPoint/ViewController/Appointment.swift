//
//  Appointment.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/16.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation


/*
data model for appointment 
 */
struct Appointment {
    
    let appointmentId: String
    let name: String
    let phone: String
    
    let doctor: String
    let date: String
    let time: String
    
    init?(_ appointmentId: String, _ dict: [String: Any]) {
    
        self.appointmentId = appointmentId
        
        guard
            let name = dict["name"] as? String,
            let phone = dict["phone"] as? String,
            let doctor = dict["doctor"] as? String,
            
            let date = dict["date"] as? String,
            let time = dict["time"] as? String
            else{return nil}
        
        
        self.name = name
        self.phone = phone
        
        self.doctor = doctor
        self.date = date
        self.time = time
        
        
    }
    
    
    
}
