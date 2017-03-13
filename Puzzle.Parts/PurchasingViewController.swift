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
	var durationData = [Discount]()
	var pricingData = [Pricing]()
	@IBOutlet weak var quantityPickerView: UIPickerView!
	@IBOutlet weak var lblStarttime: UILabel!
	@IBOutlet weak var datePickerCell: UITableViewCell!
	@IBOutlet weak var datePickerStartDate: UIDatePicker!
	//@IBOutlet weak var txtEndDate: UITextField!
	@IBOutlet weak var lblDuration: UILabel!
	@IBOutlet weak var txtPrice: UITextField!
	@IBOutlet weak var sliderQuantity: UISlider!
	@IBOutlet weak var lblQuantity: UILabel!
	var progressView: ProgressViewController?
	
	var calendarCellIndexPath: IndexPath?
	var alamofireManager = NetworkManager.shareInstance.alamoFireManager
	
	var edittingStartDate = false
	var edittingDuration = false
	var selected_discount_id: Int = 0
	var selected_pricing_id: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
		datePickerStartDate.minimumDate = Date()
		progressView = ProgressViewController(text: "")
		progressView?.isHidden = true;
		progressView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		progressView?.activityIndictor.center = (progressView?.center)!
		progressView?.center = self.view.center
		progressView?.backgroundColor = UIColor.lightGray
		quantityPickerView.delegate = self
		quantityPickerView.dataSource = self
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
			
			
			self.durationData = (self.item?.discountList)!
			self.quantityPickerView.reloadAllComponents()
			self.pricingData = (self.item?.pricingList)!
			self.sliderQuantity.maximumValue = Float(self.pricingData.count-1)
			self.sliderQuantity.minimumValue = 0
		}

    }
	
	func setupViews(){
		
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
	@IBAction func btnPurchaseTouched(_ sender: UIButton) {
		self.sendSubscribingRequest { (result) in
			let vc = Utils.getAlertView(title: "Message", message: ReturnCode.getErrorMessageWithCode(result), actions: nil)
			self.present(vc, animated: true, completion: nil)
		}
		
		
	}
	
	@IBOutlet weak var btnPurchase: UIButton!
	
	func sendSubscribingRequest(_ completion: @escaping (Int) -> Void){
		guard let user = user, let item = item else {
			return;
		}
		let url = NetworkManager.API_URL + "/subscription/purchase"
		var params = Parameters()
		params["mobilePhone"] = user.mobilePhone
		params["user_id"] = user.userId
		params["sessionID"] = user.sessionID
		params["startDate"] = ""
		params["subscription_id"] = item.id
		params["pricing_id"] = selected_pricing_id
		params["discount_id"] = selected_discount_id
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
			completion(returnCode!)
//			guard returnCode == ReturnCode.SUCCESS else {
//				completion(returnCode!)
//				return
//			}
		});
		
		
		
	}

	@IBAction func quantitySliderValueChanged(_ sender: Any) {
		let index = Int(sliderQuantity.value)
		selected_pricing_id = pricingData[index].pricing_id
		txtPrice.text = String(pricingData[index].price) + " $"
		lblQuantity.text = "\(pricingData[index].quantity)"
	}
	
	
}

extension PurchasingViewController {
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch (indexPath.section, indexPath.row)  {
		case (0,1):
			self.calendarCellIndexPath = indexPath
			if (edittingStartDate){
				return 150
			} else {
				return 0
			}
		case (0,3):
			if (edittingDuration){
				return 150
			} else {
				return 0
			}
		default:
			return 44
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch (indexPath.section, indexPath.row){
		case (0,0):
			edittingStartDate = !edittingStartDate
			self.tableView.beginUpdates()
			self.tableView.endUpdates()
			break
		case (0,2):
			edittingDuration = !edittingDuration
			self.tableView.beginUpdates()
			self.tableView.endUpdates()
			break;
		default:
			return;
		}
		
	}
}

extension PurchasingViewController {
	@IBAction func datePickerValueChanged(_ sender: Any) {
		lblStarttime.text = Utils.getStringFromDate(datePickerStartDate.date)
	}
	
}

extension PurchasingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return durationData.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let string = "\(durationData[row].duration) " + (durationData[row].duration == 1 ? "Month" : "Months")
		return string
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
		selected_discount_id = durationData[row].discount_id
		let string = "\(durationData[row].duration) " + (durationData[row].duration == 1 ? "Month" : "Months")
		lblDuration.text = string
		
	}
	
	
}

