//
//  PostsSnapshot.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/20.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import Firebase



/*
 strcut for appoinement array element.
 */
struct AppointmentFirebaseSnapshot {
    
    var appointments: [Appointment]

    init?(_ snapshot: DataSnapshot) {
        
        appointments = [Appointment]()
        
        guard let snapDictionary = snapshot.value as? [String: [String: Any]] else {return nil }
        for snap in snapDictionary {
            guard let appointment = Appointment(snap.key, snap.value) else {continue }
            appointments.append(appointment)
        }
    }
}

/*
 strcut for availability array element.
 */
struct AvailabilitySnapshot {
    
    var totalAvailability: [DoctorAvailability]
    
    init?(_ snapshot: DataSnapshot) {
        
        totalAvailability = [DoctorAvailability]()
        
        guard let snapDictionary = snapshot.value as? [String: [String: Any]] else {return nil }
        for snap in snapDictionary {
            guard let availability = DoctorAvailability(snap.key, snap.value) else {continue }
            totalAvailability.append(availability)
        }
    }

    
}
