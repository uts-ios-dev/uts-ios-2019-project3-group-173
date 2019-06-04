//
//  PopUpViewController.swift
//  DoctorsPoint
//
//  Created by Cheng Liang on 2019/5/29.
//  Copyright © 2019年 UTS. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {


    @IBAction func ClosePopUp(_ sender: Any) {
       self.view.removeFromSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
