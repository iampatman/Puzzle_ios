//
//  MainViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 6/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
	var user: User?
	var subListVC: SubscriptionListViewController? 
    override func viewDidLoad() {
        super.viewDidLoad()
		subListVC = SubscriptionListViewController()
		subListVC?.user = user;
        // Do any additional setup after loading the view.
    }
	
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

}
