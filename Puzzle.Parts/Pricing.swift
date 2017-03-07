//
//  Pricing.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 7/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class Pricing: NSObject {
	var pricing_id: Int = 0
	var subscription_id: Int = 0
	var quantity: Int = 0
	var price: Float = 0
	
	init(id: Int) {
		self.pricing_id = id
		super.init()
	}
	
	init(data: [String: Any]){
		pricing_id = (data["pricing_id"] as? Int)!
		subscription_id = (data["subscription_id"] as? Int)!
		quantity = (data["quantity"] as? Int)!
		price = (data["price"] as? Float)!
	}
}
