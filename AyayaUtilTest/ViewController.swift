//
//  ViewController.swift
//  AyayaUtilTest
//
//  Created by ayaya on 2020/7/8.
//  Copyright © 2020 Ayaya. All rights reserved.
//

import UIKit
import AyayaUtil
class ViewController: UIViewController {

    @IBOutlet weak var testView: UIView!
    
    var observation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(testView.frame)
        observation = testView.observe(\UIView.bounds, options: .new) { (view, change) in
            print("111")
            
        }
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        print(testView.frame)
    }

}

