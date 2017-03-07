//
//  ReturnCode.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 6/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class ReturnCode: NSObject {
	static let SUCCESS = 1
	static let FAILED = 0
	static let USERNAME_OR_PASS_INCORRECT = -1005
	static func getErrorMessageWithCode(_ code: Int) -> String {
		let msg = "Error Code: \(code): "
		switch code {
		case USERNAME_OR_PASS_INCORRECT:
			return msg.appending("Username or password is incorrect")
		default:
			return msg.appending("Unknown Error")
		}
	}
}
