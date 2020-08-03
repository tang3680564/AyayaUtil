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
    
    @IBOutlet weak var testTableView: UITableView!
    
    let identfit = "TestTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testTableView.register(UINib(nibName: identfit, bundle: nil), forCellReuseIdentifier: identfit)
        testTableView.delegate = self
        testTableView.dataSource = self
    
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getNibHeight(name: identfit)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identfit, for: indexPath) as? TestTableViewCell
        return cell ?? UITableViewCell()
    }
}

