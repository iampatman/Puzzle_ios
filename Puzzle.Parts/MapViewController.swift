//
//  MapViewController.swift
//  Puzzle.Parts
//
//  Created by Nguyen Bui An Trung on 2/3/17.
//  Copyright © 2017 Nguyen Bui An Trung. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
	let locationManager = CLLocationManager()
	@IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	

}



extension MapViewController : CLLocationManagerDelegate {
	private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			locationManager.requestLocation()
		}
	}
 
	private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let span = MKCoordinateSpanMake(0.05, 0.05)
			let region = MKCoordinateRegion(center: location.coordinate, span: span)
			mapView.setRegion(region, animated: true)
		}
	}
 
	private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		print("error:: (error)")
	}
}


