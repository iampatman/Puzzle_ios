//
//  Utils.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 28/2/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

public class Utils: NSObject {
	public static let PUZZLE_API_URL = "http://localhost:3001/v1"
	
	public static func initSubscriptionItemData() -> [SubscriptionItem] {
		return [
			SubscriptionItem(name: "One coffee A day", companyName: "Starbucks", id: 1),
			SubscriptionItem(name: "One Latte A day", companyName: "Starbucks", id: 2)
		]
	}
	
}
