//
//  ChooseDataBLTN.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/6/2.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import BLTNBoard
import UIKit

class ChooseDateBLTN: BLTNPageItem {
    
    lazy var datePicker = UIDatePicker()
    let myString = StringCollection()
    
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(selectedDate), for: .valueChanged)
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        return [datePicker]
        
        
        
        
    }
    
    
    @objc func selectedDate()
    {
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        let weekday = weekdayFormatter.string(from: datePicker.date)
        print(weekday)
        UserDefaults.standard.set(weekday, forKey: myString.currentSelectedWeekday)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.string(from: datePicker.date)
        print(date)
        UserDefaults.standard.set(date, forKey: myString.currentSelectedDate)
    }
 
    override func alternativeButtonTapped(sender: UIButton) {
        manager?.popItem()
    }
    
}
