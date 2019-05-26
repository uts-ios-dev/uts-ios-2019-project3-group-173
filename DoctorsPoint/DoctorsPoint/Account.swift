//
//  User.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/17.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import FirebaseAuth

struct account {
    
    let uid: String
    let email: String
    let isPatient: Bool
    
    init(_ uid: String, _ email: String, isPatient: Bool)
    {
        self.uid = uid
        self.email = email
        self.isPatient = isPatient
    }
    
}
