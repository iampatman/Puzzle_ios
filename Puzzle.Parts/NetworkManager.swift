//
//  NetworkManager.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 6/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
	public static let API_URL = "http://192.168.1.231:3001"

	class var shareInstance: NetworkManager {
		struct Singleton {
			static let _instance = NetworkManager()
		}
		return Singleton._instance
	}
	
	
	var alamoFireManager : Alamofire.SessionManager?
	override init(){
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = 150
		configuration.timeoutIntervalForResource = 150
		alamoFireManager = Alamofire.SessionManager(configuration: configuration)
	}
}
