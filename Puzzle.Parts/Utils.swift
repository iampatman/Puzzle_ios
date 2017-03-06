//
//  Utils.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 28/2/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

public class Utils: NSObject {
	public static let PUZZLE_API_URL = "http://172.23.135.202:3001"
	public static let SECRET_KEY = "abc!@#123"
	public static func initSubscriptionItemData() -> [SubscriptionItem] {
		return [
			SubscriptionItem(name: "One coffee A day", companyName: "Starbucks", id: 1),
			SubscriptionItem(name: "One Latte A day", companyName: "Starbucks", id: 2)
		]
	}
	
	public static func validateEmail(_ email: String){
		
	}
	
	private static func sha256(_ data: Data) -> Data? {
		guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else { return nil }
		CC_SHA256((data as NSData).bytes, CC_LONG(data.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
		return res as Data
	}
	
	private static func sha256(_ str: String) -> String? {
		guard
			let data = str.data(using: String.Encoding.utf8),
			let shaData = sha256(data)
			else { return nil }
		let rc = shaData.base64EncodedString(options: [])
		return rc
	}
	
	public static func getSigWithParams(_ params: [Any]) -> String{
		var input = ""
		params.forEach { (element) in
			input.append(element as! String)
			input.append("|")
		}
		input.append(SECRET_KEY)
		let result = Utils.sha256(input)
		return result!
	}
	
	public static func getAlertView(title: String, message: String, actions: [UIAlertAction]?) -> UIAlertController{
		let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
		if actions == nil  {
			let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
			alertView.addAction(defaultAction)
		} else {
			actions?.forEach { (action) in
				alertView.addAction(action)
			}
		}
		return alertView;
	}
}
