//
//  ChooseWeekday.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/31.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import BLTNBoard
import CollectionKit

class ChooseWeekdayBLTN: BLTNPageItem {
    
    
    let myString = StringCollection()
    var weekdayCollection: [String] = []
    let collectionView = CollectionView()
    var currentIndex : Int = 0
    var previousIndex: Int = 0
    var arrangedSubViews: [UIView] = []
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        prepareData()
        
        if weekdayCollection.isEmpty
        {}
        else
        {
            collectionView.contentInset = UIEdgeInsets(top: 60, left: 20, bottom: 10, right: 20)
            collectionView.contentInsetAdjustmentBehavior = .automatic
            
            let viewSource = ClosureViewSource(viewUpdater: { (view: UILabel, data: String, index: Int) in
                view.backgroundColor = UIColor(red: 232/255, green: 122/255, blue: 144/255, alpha: 1)
                view.text = "\(data)"
                view.textColor = .white
                view.textAlignment = .center
                view.font = .boldSystemFont(ofSize: 20)
            })
            
            collectionView.provider = BasicProvider(
                dataSource: weekdayCollection,
                viewSource: viewSource,
                sizeSource: { (_, view, size) -> CGSize in
                    return CGSize(width: size.width, height: 50)
            },
                layout: FlowLayout(lineSpacing: 15,
                                   interitemSpacing: 15,
                                   justifyContent: .center,
                                   alignItems: .center,
                                   alignContent: .center),
                tapHandler: { [weak self] context in
                    self!.currentIndex = context.index
                    let currentSelectedDay: String = (self?.weekdayCollection[self!.currentIndex])!
                    UserDefaults.standard.set(currentSelectedDay, forKey: self!.myString.currentSelectedDay)
                    print("Selected Weekday is " + UserDefaults.standard.string(forKey: self!.myString.currentSelectedDoctor)!)
                    self!.collectionView.cell(at: self!.previousIndex)?.backgroundColor? = UIColor(red: 232/255, green: 122/255, blue: 144/255, alpha: 1)
                    self!.collectionView.cell(at: self!.currentIndex)?.backgroundColor? = UIColor(red: 0/255, green: 111/255, blue: 255/255, alpha: 1)
                    self!.previousIndex = self!.currentIndex
                }
                
            )
            
            collectionView.animator = WobbleAnimator()
            
            arrangedSubViews.append(collectionView)
        }
        
        return arrangedSubViews
    }
    
    
    
    
    
    func updateWeekdayCollection(_ isEmpty: Bool,  _ id: Int)
    {
        if !isEmpty
        {
            switch id {
            case 1:
                weekdayCollection.append(myString.weekdays[0])
            case 2:
                weekdayCollection.append(myString.weekdays[1])
            case 3:
                weekdayCollection.append(myString.weekdays[2])
            case 4:
                weekdayCollection.append(myString.weekdays[3])
            case 5:
                weekdayCollection.append(myString.weekdays[4])
            default:
                print(weekdayCollection.count)
            }
        }
    }
    
    func prepareData() {
        let isMonday = UserDefaults.standard.stringArray(forKey: myString.mondayTimetable)!.isEmpty
        let isTuesday = UserDefaults.standard.stringArray(forKey: myString.tuesdayTimetable)!.isEmpty
        let isWednesday = UserDefaults.standard.stringArray(forKey: myString.wednesdayTimetable)!.isEmpty
        let isThursday = UserDefaults.standard.stringArray(forKey: myString.thursdayTimetable)!.isEmpty
        let isFriday = UserDefaults.standard.stringArray(forKey: myString.fridayTimetable)!.isEmpty
        
        updateWeekdayCollection(isMonday, 1)
        updateWeekdayCollection(isTuesday, 2)
        updateWeekdayCollection(isWednesday, 3)
        updateWeekdayCollection(isThursday, 4)
        updateWeekdayCollection(isFriday, 5)
    }
    
    
    
    
}
