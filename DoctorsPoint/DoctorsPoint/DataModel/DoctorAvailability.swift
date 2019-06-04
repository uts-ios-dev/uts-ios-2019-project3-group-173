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
    
    let time09: Int
    let time10: Int
    let time11: Int
    let time12: Int
    
    let time13: Int
    let time14: Int
    let time15: Int
    let time16: Int
    
    let time17: Int
    let time18: Int
    
    init?(_ weekday: String, _ dict: [String: Any]) {
        

        self.weekday = weekday
        
        guard
            let time09 = dict["09:00"] as? Int,
            let time10 = dict["10:00"] as? Int,
            let time11 = dict["11:00"] as? Int,
            let time12 = dict["12:00"] as? Int,
            let time13 = dict["13:00"] as? Int,
            let time14 = dict["14:00"] as? Int,
            let time15 = dict["15:00"] as? Int,
            let time16 = dict["16:00"] as? Int,
            let time17 = dict["17:00"] as? Int,
            let time18 = dict["18:00"] as? Int
            else{return nil}
        
        self.time09 = time09
        self.time10 = time10
        self.time11 = time11
        self.time12 = time12
        
        self.time13 = time13
        self.time14 = time14
        self.time15 = time15
        self.time16 = time16
        
        self.time17 = time17
        self.time18 = time18
        
    }
    
    
    
}
