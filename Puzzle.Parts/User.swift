//
//  User.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 28/2/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class User: NSObject {
	var mobilePhone: String = ""
	var sessionID: String = ""
	var email: String = ""
	var name: String = ""
	var userId: Int = 0
	override init() {
		super.init()
		mobilePhone = ""
	}
	init(mobile: String){
		super.init()
		sessionID = ""
		email = ""
		mobilePhone = mobile
	}
	
}
