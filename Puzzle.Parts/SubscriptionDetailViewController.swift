//
//  SubscriptionDetailViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 1/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire
class SubscriptionDetailViewController:  UIViewController {
	@IBOutlet weak var tableView: UITableView?
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	@IBOutlet weak var reviewsContainer: UIView!
	@IBOutlet weak var detailsContainer: UIView!
	@IBOutlet weak var btnSubscribe: UIButton!
	var containers: [UIView]?
	@IBOutlet weak var itemDescription: UITextView!
	
	var item: SubscriptionItem? = nil
	var user: User?
	@IBOutlet weak var lblItemName: UILabel!
	@IBOutlet weak var btnCompany: UIButton!
	
	
	var itemDetailVC: ItemDetailController?
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.detailsContainer.alpha = 1;
		self.reviewsContainer.alpha = 0;
		containers = [detailsContainer,reviewsContainer]
		btnSubscribe.layer.cornerRadius = 5;
		btnSubscribe.layer.borderWidth = 1;
		btnSubscribe.layer.borderColor = UIColor.blue.cgColor
    }
	

	override func viewWillAppear(_ animated: Bool) {
		guard item != nil else {
			return
		}
		lblItemName.text = item?.name
		btnCompany.titleLabel?.text = (item?.companyName)! + " >"
		btnSubscribe.titleLabel?.text = "From 17$/m"
		btnSubscribe.titleLabel?.sizeToFit()
		self.itemDetailVC?.item = self.item
		//performSegue(withIdentifier: "showItemDetailInfo", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showItemDetailInfo" {
			if let vc = segue.destination as? ItemDetailController {
				self.itemDetailVC = vc
				//vc.item = self.item
			}
		}
		if segue.identifier == "showPurchasingScreen" {
			if let vc = segue.destination as? PurchasingViewController {
				vc.item = self.item
				vc.user = self.user
			}
		}
	}
	
	@IBAction func btnCompanyTouched(_ sender: Any) {
		
	}
	
	
	func fetchSubscriptionDetailData(_ completion: @escaping (Int) -> Void ){
		
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
