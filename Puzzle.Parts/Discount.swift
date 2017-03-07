//
//  Discount.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 7/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class Discount: NSObject {
	var discount_id: Int = 0
	var subscription_id: Int = 0
	var discount: Float = 0
	var duration: Int = 0
	
	init(id: Int){
		super.init()
		self.discount_id = id
	}
	
	init(data: [String: Any]) {
		super.init()
		self.discount_id = data["discount_id"] as! Int
		self.subscription_id = data["subscription_id"] as! Int
		self.discount = data["discount"] as! Float
		self.duration = data["duration"] as! Int
	}
}
