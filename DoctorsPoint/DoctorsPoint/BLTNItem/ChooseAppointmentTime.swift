//
//  ChooseAppointmentTime.swift
//  DoctorsPoint
//
//  Created by Jiajian Liang on 2019/5/30.
//  Copyright © 2019年 UTS. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import BLTNBoard
import CollectionKit

class ChooseAppointmentTime : BLTNPageItem {
    
    let myString = StringCollection()
    
    let selectionSuper = SelectionBLTNSuper()
    let collectionView = CollectionView()
    
    var arrangedSubViews: [UIView] = []
    var appointmentTime: [String] = []
    
    var currentIndex : Int = 0
    var previousIndex: Int = 0
    
    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
        
        doctorList = UserDefaults.standard.stringArray(forKey: self.myString.doctorList)!
        
        if doctorList.isEmpty
        {
            self.descriptionText = "😢😢Opps😢😢\n\n Something was going wrong \n\n Go back and try again"
            self.actionButtonTitle = nil
        }
        else
        {
            collectionView.contentInset = UIEdgeInsets(top: 80, left: 20, bottom: 10, right: 20)
            collectionView.contentInsetAdjustmentBehavior = .automatic
            
            let viewSource = ClosureViewSource(viewUpdater: { (view: UILabel, data: String, index: Int) in
                view.backgroundColor = UIColor(red: 232/255, green: 122/255, blue: 144/255, alpha: 1)
                view.text = "\(data)"
                view.textColor = .white
                view.textAlignment = .center
                view.font = .boldSystemFont(ofSize: 20)
            })
            
            collectionView.provider = BasicProvider(
                dataSource: doctorList,
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
                    let currentSelectDoctor: String = (self?.doctorList[self!.currentIndex])!
                    UserDefaults.standard.set(currentSelectDoctor, forKey: self!.myString.currentSelectedDoctor)
                    print("Selected Doctor is " + UserDefaults.standard.string(forKey: self!.myString.currentSelectedDoctor)!)
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
    
    override func actionButtonTapped(sender: UIButton) {
        manager?.displayNextItem()
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        doctorList.removeAll()
        manager?.popItem()
    }
    
    
}
