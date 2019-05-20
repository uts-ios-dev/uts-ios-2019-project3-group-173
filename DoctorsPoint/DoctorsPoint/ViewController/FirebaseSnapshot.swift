//
//  PostsSnapshot.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/20.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseSnapshot {
    
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
