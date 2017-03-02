//
//  SubscriptionDetailViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 1/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class SubscriptionDetailViewController:  UIViewController {
	@IBOutlet weak var tableView: UITableView?
	var item: SubscriptionItem? = nil
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var reviewsContainer: UIView!
	@IBOutlet weak var detailsContainer: UIView!
	@IBOutlet weak var btnSubscribe: UIButton!
	var containers: [UIView]?

	@IBOutlet weak var itemDescription: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.detailsContainer.alpha = 1;
		self.reviewsContainer.alpha = 0;
		containers = [detailsContainer,reviewsContainer]
		btnSubscribe.layer.cornerRadius = 5;
		btnSubscribe.layer.borderWidth = 1;
		btnSubscribe.layer.borderColor = UIColor.blue.cgColor

    }

	
	@IBAction func changeTab(_ sender: Any) {
		containers?.forEach({ (view) in
			view.alpha = 0;
		})
		containers?[segmentedControl.selectedSegmentIndex].alpha = 1;
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


extension SubscriptionDetailViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1;
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 100;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView?.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell?.textLabel?.text = "Test \(indexPath.row)"
		return cell!;
	}
}
