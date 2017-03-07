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
	
	@IBOutlet weak var photoScrollView: UIScrollView!
	@IBOutlet weak var textViewDescription: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let image = UIImage(named: "starbucks-logo")
		let imageView = UIImageView(image: image)
		let height = Int(photoScrollView.frame.height - 5)
		imageView.frame = CGRect(x: 0, y: 0, width: height, height: height)
		imageView.contentMode = .scaleAspectFit
		photoScrollView.addSubview(imageView)
		imageView.frame = CGRect(x: height * 1, y: 0, width: height, height: height)
		photoScrollView.addSubview(imageView)
		imageView.frame = CGRect(x: height * 2, y: 0, width: height, height: height)
		photoScrollView.addSubview(imageView)
		photoScrollView.addSubview(imageView)
		photoScrollView.addSubview(imageView)
		photoScrollView.contentSize = CGSize(width: height*5, height: height)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		textViewDescription.text = item?.itemDescription
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
