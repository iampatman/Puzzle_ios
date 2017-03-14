//
//  TransactionViewCell.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 14/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class TransactionViewCell: UITableViewCell {

	@IBOutlet weak var lblSubscriptionName: UILabel!
	@IBOutlet weak var lblRemainingTimes: UILabel!
	@IBOutlet weak var lblExpireDate: UILabel!
	@IBOutlet weak var subImageView: UIImageView!
	var transaction: Transaction? {
		didSet {
			lblSubscriptionName.text = transaction?.subscriptionName
			lblRemainingTimes.text = "Remaining times: \(transaction?.remainingTimes)"
		}
	}
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

    }

}
