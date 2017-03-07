//
//  PurchasingViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 7/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire
class PurchasingViewController: UITableViewController {
	
	var user: User?
	var item: SubscriptionItem?
	
	@IBOutlet weak var txtStartDate: UITextField!
	@IBOutlet weak var txtEndDate: UITextField!
	@IBOutlet weak var txtPrice: UITextField!
	@IBOutlet weak var sliderQuantity: UISlider!
	@IBOutlet weak var lblQuantity: UILabel!
	var progressView: ProgressViewController?
	var alamofireManager = NetworkManager.shareInstance.alamoFireManager
    override func viewDidLoad() {
        super.viewDidLoad()
		txtStartDate.text = "Today"
		progressView = ProgressViewController(text: "")
		progressView?.isHidden = true;
		progressView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		progressView?.activityIndictor.center = (progressView?.center)!
		progressView?.center = self.view.center
		progressView?.backgroundColor = UIColor.lightGray
		self.view.addSubview(progressView!)
		progressView?.show()
		fetchItemDetails { (result) in
			self.progressView?.hide()
			if (result != ReturnCode.SUCCESS){
				let alertView = Utils.getAlertView(title: "Error", message: ReturnCode.getErrorMessageWithCode(result), actions: nil)
				self.present(alertView, animated: true, completion: { 
					self.dismiss(animated: true, completion: nil)
				})
			}
		}

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

	func fetchItemDetails(_ completion: @escaping (Int) -> Void){
		guard let user = user, let item = item else {
			return;
		}
		let url = NetworkManager.API_URL + "/subscription/getdetailbyid"
		var params = Parameters()
		params["mobilePhone"] = user.mobilePhone
		params["sessionID"] = user.sessionID
		params["subscription_id"] = item.id
		params["sig"] = ""
		alamofireManager?.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON(completionHandler: { (response) in
			guard (response.result.isSuccess == true) else {
				completion(ReturnCode.FAILED)
				return;
			}
			
			guard let data = response.result.value as? [String:Any] else {
				completion(ReturnCode.FAILED)
				return;
			}
			
			let returnCode = data["returnCode"] as? Int
			guard returnCode == ReturnCode.SUCCESS else {
				completion(returnCode!)
				return
			}
			if let pricingListData = data["pricingList"] as! [[String:Any]]? {
				var pricingList = [Pricing]()
				pricingListData.forEach({ (pricingData) in
					let item = Pricing(data: pricingData)
					pricingList.append(item)
				})
				item.pricingList = pricingList
			}
			
			if let discountListData = data["discountList"] as! [[String:Any]]? {
				var discountList = [Discount]()
				discountListData.forEach({ (discountData) in
					let item = Discount(data: discountData)
					discountList.append(item)
				})
				item.discountList = discountList
			}
			completion(returnCode!)
			
		})
	}
}
