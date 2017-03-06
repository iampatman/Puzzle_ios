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
	var rating: Float = 0
	var smallImageURL: String = ""
	var introduction: String = ""
	override init() {
		super.init()
	}
	
	init(name: String, companyName: String, id: Int) {
		self.name = name
		self.companyName = companyName
		self.id = id;
	}
	init(data: [String: Any]){
		self.name = data["name"] as! String
		self.companyName = data["companyName"] as! String
		self.id = data["subscription_id"] as! Int
		//self.smallImageURL = data["smallImage"] as! String
		self.introduction = data["introduction"] as! String
		self.rating = data["rating"] as! Float

		/*
		{
		"subscription_id": 1,
		"name": "Starbucks",
		"introduction": "Best coffee",
		"rating": 0,
		"smallImage": null,
		"companyId": 1,
		"companyName": "Starbucks"
		},
		*/
	}
}
