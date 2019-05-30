//
//  ChooseTimeBLTN.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/30.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import BLTNBoard
import CollectionKit

class ChooseTimeBLTN: BLTNPageItem {
    
    let myString = StringCollection()
    
    var mondayData: [String] = []
    var tuesdayData: [String] = []
    var wednesdayData: [String] = []
    var thursdayData: [String] = []
    var fridayData: [String] = []
    
    
    var arrangedSubViews: [UIView] = []
    let timeCollectionView = CollectionView()
    var currentIndex : Int = 0
    var previousIndex: Int = 0
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        prepareData()
        
        if mondayData.count == 0 && tuesdayData.count == 0 && wednesdayData.count == 0 && thursdayData.count == 0 && fridayData.count == 0
        {
            self.descriptionText = myString.makeAppointmentErrorMessage
            self.actionButtonTitle = nil
        }
        else
        {
            let doctor = UserDefaults.standard.string(forKey: myString.currentSelectedDoctor)!
            self.descriptionText = "When do you want to meet \(doctor)?"
            self.actionButtonTitle = "Continue"
            self.alternativeButtonTitle = "Go Back"
            
            timeCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
            
            let mondayTitle = prepareWeekdaySection(1)
            let tuesdayTitle = prepareWeekdaySection(2)
            let wednesdayTitle = prepareWeekdaySection(3)
            let thursdayTitle = prepareWeekdaySection(4)
            let fridayTitle = prepareWeekdaySection(5)
            
            
            let mondaySection = prepareSection(mondayData)
            let tuesdaySection = prepareSection(tuesdayData)
            let wednesdaySection = prepareSection(wednesdayData)
            let thursdaySection = prepareSection(thursdayData)
            let fridaySection = prepareSection(fridayData)
            
            let finalProvider = ComposedProvider(sections: [mondayTitle,
                                                            mondaySection,
                                                            tuesdayTitle,
                                                            tuesdaySection,
                                                            wednesdayTitle,
                                                            wednesdaySection,
                                                            thursdayTitle,
                                                            thursdaySection,
                                                            fridayTitle,
                                                            fridaySection])
            
            timeCollectionView.provider = finalProvider
            
            timeCollectionView.animator = WobbleAnimator()
            arrangedSubViews.append(timeCollectionView)
        }
        return arrangedSubViews
    }
    
    
    
    func prepareSection(_ dataSource: [String]) -> Provider
    {
        let sections = BasicProvider(
            dataSource: dataSource,
            viewSource: ClosureViewSource(viewUpdater: { (view: UIButton , data: String, index: Int) in
                view.backgroundColor = UIColor(red: 232/255, green: 122/255, blue: 144/255, alpha: 1)
                view.setTitle("\(data)", for: .normal)
            }),
            sizeSource:  { (index, data, maxSize) -> CGSize in
                return CGSize(width: 80, height: 80)
        },
            layout: FlowLayout(spacing: 10, justifyContent: .spaceAround, alignItems: .center)
                .inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
        
        return sections
    }
    
    func prepareWeekdaySection(_ id: Int) -> Provider
    {
        let weekday = getWeekday(id)
        
        
        let viewSource = ClosureViewSource(viewUpdater: { (view: UILabel, data: String, index: Int) in
            view.backgroundColor = UIColor(red: 252/255, green: 159/255, blue: 77/255, alpha: 1)
            view.text = "\(data)"
            view.textAlignment = .center
            view.textColor = .white
        })
        
        let sections = BasicProvider(
            dataSource: [weekday],
            viewSource: viewSource,
            sizeSource:  { (index, data, maxSize) -> CGSize in
                return CGSize(width: 270, height: 40)
        },
            layout: FlowLayout(lineSpacing: 15,
                               interitemSpacing: 15,
                               justifyContent: .center,
                               alignItems: .start,
                               alignContent: .start))
        return sections
    }
    
    func getWeekday(_ id: Int) -> String
    {
        switch id {
        case 1:
            return myString.weekdays[0]
        case 2:
            return myString.weekdays[1]
        case 3:
            return myString.weekdays[2]
        case 4:
            return myString.weekdays[3]
        case 5:
            return myString.weekdays[4]
        default:
            return ""
        }
    }
    
    
    
    func prepareData()
    {
        
        mondayData = UserDefaults.standard.stringArray(forKey: myString.mondayTimetable)!
        tuesdayData = UserDefaults.standard.stringArray(forKey: myString.tuesdayTimetable)!
        wednesdayData = UserDefaults.standard.stringArray(forKey: myString.wednesdayTimetable)!
        thursdayData = UserDefaults.standard.stringArray(forKey: myString.thursdayTimetable)!
        fridayData = UserDefaults.standard.stringArray(forKey: myString.fridayTimetable)!
    }
    
    
    override func alternativeButtonTapped(sender: UIButton) {
        eraseTempData()
        manager?.popItem()
    }
    
    override func actionButtonTapped(sender: UIButton) {
        print("go to confirm page send")
        //next or dismiss
    }
    
    func eraseTempData()
    {
        mondayData.removeAll()
        tuesdayData.removeAll()
        wednesdayData.removeAll()
        thursdayData.removeAll()
        fridayData.removeAll()
        
        UserDefaults.standard.removeObject(forKey: myString.mondayTimetable)
        UserDefaults.standard.removeObject(forKey: myString.tuesdayTimetable)
        UserDefaults.standard.removeObject(forKey: myString.wednesdayTimetable)
        UserDefaults.standard.removeObject(forKey: myString.thursdayTimetable)
        UserDefaults.standard.removeObject(forKey: myString.fridayTimetable)
        
    }
    
}
