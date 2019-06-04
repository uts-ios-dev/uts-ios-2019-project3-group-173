//
//  DatabaseService.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/17.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase
import FirebaseAuth

class DatabaseService {
    
    var user: User?
    var appointmentReference: DatabaseReference?
    var userReference: DatabaseReference?
    var doctorReference: DatabaseReference?
    var availabilityReference: DatabaseReference?
    
    let myString = StringCollection()
    
    init(_ user: User)
    {
        self.user = user
        
        self.appointmentReference = Database.database().reference().child(myString.appointment).child(user.uid)
        self.userReference = Database.database().reference().child(myString.account).child(user.uid)
        self.doctorReference = Database.database().reference().child(myString.doctors)
        self.availabilityReference = Database.database().reference().child(myString.availability)
    }
        
}
