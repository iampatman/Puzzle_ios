//
//  ItemDetailController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 2/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit

class ItemDetailController: UITableViewController {
	var item: SubscriptionItem?
	
	@IBOutlet weak var textViewDescription: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		textViewDescription.text = item?.itemDescription
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
