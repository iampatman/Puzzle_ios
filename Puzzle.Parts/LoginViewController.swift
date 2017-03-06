//
//  LoginViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 6/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {

	@IBOutlet weak var txtPassword: UITextField!
	@IBOutlet weak var txtMobilePhone: UITextField!
	let alamofire = NetworkManager.shareInstance.alamoFireManager
	var mainViewController: MainViewController?
	var progressView: ProgressViewController?
	var user: User? = User()
    override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()
    }
	
	func setupViews(){
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		mainViewController = storyboard.instantiateViewController(withIdentifier: "MainScreenViewController") as? MainViewController
		if let naviVC = mainViewController?.viewControllers?[0] as? UINavigationController {
			if let vc = naviVC.viewControllers[0] as? SubscriptionListViewController {
				vc.user = user;
			}
		}
		progressView = ProgressViewController(text: "Logging in")
		progressView?.isHidden = true;
		self.view.addSubview(progressView!)
	}

	@IBAction func signinBtnOnClick(_ sender: Any) {
		let mobile = txtMobilePhone.text?.trimmingCharacters(in: .whitespaces)
		let password = txtPassword.text?.trimmingCharacters(in: .whitespaces)
		guard mobile != "" && password != "" else {
			let alertView = Utils.getAlertView(title: "Error", message: "Username and password must not be empty", actions: nil)
			self.present(alertView, animated: true, completion: nil)
			return;
		}
		progressView?.show()
		sendLoginRequest(mobile: mobile!, password: password!) { (retCode) in
			self.progressView?.hide()
			if retCode == ReturnCode.SUCCESS {
				self.mainViewController?.user = self.user
				self.present(self.mainViewController!, animated: true, completion: nil)
			} else {
				let message = ReturnCode.getErrorMessageWithCode(retCode)
				let alertView = Utils.getAlertView(title: "Error", message: message, actions: nil)
				self.present(alertView, animated: true, completion: nil)
			}
		}
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	func sendLoginRequest(mobile: String, password: String, completion: @escaping (Int) -> Void){
		let sig = Utils.getSigWithParams([mobile, password])
		let url = NetworkManager.API_URL + "/user/login"
		let params = ["mobilePhone": mobile, "password": password, "sig": sig]
		alamofire?.request(url, method: .post, parameters: params , encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
			guard (response.result.isSuccess == true) else {
				completion(ReturnCode.FAILED)
				return;
			}
			if let data = response.result.value as? NSDictionary {
				let returnCode = data["returnCode"] as! Int
				let sessionID = data["sessionID"] as! String
				self.user?.mobilePhone = mobile
				self.user?.sessionID = sessionID
				completion(returnCode)
				
			}
		}
	}
}
