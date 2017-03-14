//
//  DashboardViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 13/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import Alamofire

class DashboardViewController: UITableViewController {

	var user: User?
	var data = [Transaction]()
	
	var alamofireManager = NetworkManager.shareInstance.alamoFireManager
	var progressView: ProgressViewController?

	override func viewDidLoad() {
        super.viewDidLoad()
		setupViews()

		if user != nil {
			fetchDataList()
		}
		
    }
	
	func setupViews(){
		progressView = ProgressViewController(text: "")
		progressView?.isHidden = true;
		progressView?.center = self.view.center
		self.view.addSubview(progressView!)
	}
	func fetchDataList(){
		self.progressView?.show()
		fetchData { (result) in
			self.progressView?.hide()
			if (result == ReturnCode.SUCCESS){
				self.tableView.reloadData();
			} else {
				let alertView = Utils.getAlertView(title: "Error", message: ReturnCode.getErrorMessageWithCode(result), actions: nil)
				self.present(alertView, animated: true, completion: nil)
			}
		}
	}

	func fetchData(_ complete: @escaping (Int) -> Void){
		var params = Parameters()
		params["userId"] = user?.userId
		params["mobilePhone"] = user?.mobilePhone
		params["sessionID"] = user?.sessionID
		params["sig"] = ""
		let url = NetworkManager.API_URL + "/transaction/get"
		alamofireManager?.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
			guard response.result.isSuccess == true else {
				complete(ReturnCode.FAILED)
				return;
			}
			
			if let data = response.result.value as? NSDictionary {
				let returnCode = data["returnCode"] as! Int
				guard returnCode == ReturnCode.SUCCESS else {
					complete(returnCode)
					return
				}
				let list = data["list"] as! [[String: Any]]
				list.forEach({ (itemJson) in
					let item = Transaction(data: itemJson);
					self.data.append(item)
				})
				complete(returnCode)
			}
			
			
		})
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionViewCell
		cell.transaction = data[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
