//
//  Transaction.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 28/2/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class Transaction: NSObject {
	var subscriptionName: String = ""
	var transactionId: String = ""
	var subscriptionId: Int = 0
	var pricingId: Int = 0
	var remainingTimes: Int = 0
	var endDate: String = ""
	
	override init() {
		super.init()
	}
	
	init(data: [String: Any]){
		super.init()
		self.subscriptionName = data["subscription_name"] as! String
		self.transactionId = data["transaction_id"] as! String
		self.subscriptionId = data["subscription_id"] as! Int
		self.endDate = data["end_date"] as! String
		self.remainingTimes = data["remaining_times"] as! Int
	}
	
}
