//
//  SubscriptionListViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 28/2/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire

class SubscriptionListViewController: UITableViewController {
	let alamofire = NetworkManager.shareInstance.alamoFireManager
	var progressView: ProgressViewController?
	var data = [SubscriptionItem]()
	var user: User?
	
	
	lazy var detailViewController: SubscriptionDetailViewController = {
		let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubscriptionDetailNaviController") as? UINavigationController
		let vc = nextVC?.viewControllers[0] as? SubscriptionDetailViewController
		return vc!
	} ()
    override func viewDidLoad() {
        super.viewDidLoad()
		//data =  Utils.initSubscriptionItemData()
		if user != nil {
			fetchDataList()
		}
    }
	func setupViews(){
		progressView = ProgressViewController(text: "")
		progressView?.isHidden = true;
		self.view.addSubview(progressView!)
	}
	func fetchDataList(){
		self.progressView?.show()
		fetchSubscriptionList { (result) in
			self.progressView?.hide()
			if (result == ReturnCode.SUCCESS){
				self.tableView.reloadData();
			} else {
				let alertView = Utils.getAlertView(title: "Error", message: ReturnCode.getErrorMessageWithCode(result), actions: nil)
				self.present(alertView, animated: true, completion: nil)
			}
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	
	func fetchSubscriptionList(_ completion: @escaping (Int)-> Void){
		let sig = ""
		let url = NetworkManager.API_URL + "/subscription/getlist"
		let params = ["mobilePhone": user?.mobilePhone, "sessionID": user?.sessionID, "sig": sig]
		alamofire?.request(url, method: .post, parameters: params , encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
			guard (response.result.isSuccess == true) else {
				completion(ReturnCode.FAILED)
				return;
			}
			
			if let data = response.result.value as? NSDictionary {
				let returnCode = data["returnCode"] as! Int
				let list = data["list"] as! [[String: Any]]
				list.forEach({ (itemJson) in
					let item = SubscriptionItem(data: itemJson);
					self.data.append(item)
				})
				completion(returnCode)
			}
		}

	}
	


}

extension SubscriptionListViewController {
	
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return data.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath) as? SubscriptionViewCell
		cell?.item = data[indexPath.row]
		return cell!
	}
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.detailViewController.item = data[indexPath.row]
		self.detailViewController.user = self.user
		navigationController?.pushViewController(self.detailViewController, animated: true)
	}
	
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(100)
	}
}
