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

class DatabaseService {
    
    var user: User?
    var appointmentReference: DatabaseReference?
    var userReference: DatabaseReference?
    let myString = StringCollection()
    
    init(_ user: User)
    {
        self.user = user
        
        self.appointmentReference = Database.database().reference().child(myString.appointment).child(user.uid)
        self.userReference = Database.database().reference().child(myString.account).child(user.uid)
    }
}
