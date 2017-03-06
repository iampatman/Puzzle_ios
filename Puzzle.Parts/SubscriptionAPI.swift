//
//  SubscriptionAPI.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 2/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire
class SubscriptionAPI: NSObject {
	class var sharedAPI : SubscriptionAPI {
		struct Singleton{
			static let _instance = SubscriptionAPI()
		}
		return Singleton._instance
	}
	
	
	func loadSubscriptionItems(_ user: User) -> [SubscriptionItem] {
		let url = Utils.PUZZLE_API_URL + "/subscription/get"
		var params = Parameters()
		params["username"] = ""
		params["sessionID"] = ""
		params["sig"] = ""
		Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
			
		}
		return [SubscriptionItem]()
	}
}
