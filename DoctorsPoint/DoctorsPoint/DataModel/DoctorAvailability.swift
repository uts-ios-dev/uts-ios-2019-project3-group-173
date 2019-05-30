//
//  Appointment.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/16.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation

struct DoctorAvailability {
    
    let weekday: String
    let time9: Int
    let time12: Int
    let time15: Int
    
    init?(_ weekday: String, _ dict: [String: Any]) {
        

        self.weekday = weekday
        
        guard
            let time9 = dict["09:00"] as? Int,
            let time12 = dict["12:00"] as? Int,
            let time15 = dict["15:00"] as? Int
            else{return nil}
        
        self.time9 = time9
        self.time12 = time12
        self.time15 = time15
        
        
    }
    
    
    
}
