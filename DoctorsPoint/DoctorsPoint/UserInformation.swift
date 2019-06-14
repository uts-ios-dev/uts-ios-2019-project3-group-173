//
//  User.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/17.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import FirebaseAuth



/*
 data structure for User Information
 */

struct UserInformation {
    
    let uid: String
    let name: String
    let email: String
    let photoUrl: URL
    let phone: String
    let level: Int
    
    init(_ uid: String, _ name: String, _ email: String, _ photoUrl: URL, _ phone: String , _ level: Int)
    {
        self.uid = uid
        self.name = name
        self.email = email
        self.photoUrl = photoUrl
        self.phone = phone
        self.level = level
    }
    
}
