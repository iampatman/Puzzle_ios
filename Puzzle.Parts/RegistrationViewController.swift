//
//  RegistrationViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 2/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire

class RegistrationViewController: UIViewController {

	@IBOutlet weak var txtMobilePhone: UITextField!
	@IBOutlet weak var txtName: UITextField!
	@IBOutlet weak var txtPassword: UITextField!
	
	let alamoFireManager = NetworkManager.shareInstance.alamoFireManager!
	
	@IBAction func btnJoinnowClicked(_ sender: Any) {
//		let mobilePhone = txtMobilePhone.text?.trimmingCharacters(in: .whitespaces)
//		let name = txtName.text?.trimmingCharacters(in: .whitespaces)
//		let password = txtPassword.text?.trimmingCharacters(in: .whitespaces)
//		var user: User = User()
		sendSignUpRequest { (result) in
			self.dismiss(animated: true, completion: nil)
		}
		
	}
	
	func dismissKeyboard(){
		
	}
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	func sendSignUpRequest(_ completion: @escaping (Int) -> Void){
		let mobilePhone = txtMobilePhone.text?.trimmingCharacters(in: .whitespaces)
		let name = txtName.text?.trimmingCharacters(in: .whitespaces)
		let password = txtPassword.text?.trimmingCharacters(in: .whitespaces)
		let url = NetworkManager.API_URL + "/user/register"
		let params = ["mobilePhone": mobilePhone, "name": name, "password": password ]
		alamoFireManager.request(url, method: .post, parameters: params , encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (response) in
			guard (response.result.isSuccess == true) else {
				completion(ReturnCode.FAILED)
				return;
			}
			if let data = response.result.value as? NSDictionary {
				let returnCode = data["returnCode"] as? Int
				completion(returnCode!)
			}
		}
		
	}
	


}
