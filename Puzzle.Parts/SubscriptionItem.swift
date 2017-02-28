//
//  SubscriptionItem.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 28/2/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

public class SubscriptionItem: NSObject {
	var name: String = ""
	var companyName: String = ""
	var id: Int = 0;
	var imageURL: String = ""
	override init() {
		super.init()
	}
	
	init(name: String, companyName: String, id: Int) {
		self.name = name
		self.companyName = companyName
		self.id = id;
	}
}
