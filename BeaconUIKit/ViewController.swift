//
//  ViewController.swift
//  BeaconUIKit
//
//  Created by Justin Hold on 3/1/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
	
	// MARK: - VIEW PROPERTIES
	var locationManager: CLLocationManager?
	
	
	// MARK: - @IBOUTLET
	@IBOutlet var distanceReading: UILabel!
	
	
	// MARK: - VIEWDIDLOAD
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		locationManager = CLLocationManager()
		locationManager?.delegate = self
		locationManager?.requestAlwaysAuthorization()
		
		view.backgroundColor = .gray
	}
	
	// MARK: - @OBJC FUNCTIONS
	@objc func something() {
		//
	}
	
	// MARK: - FUNCTIONS
	func somethingElse() {
		//
	}
	
	func locationManager(
		_ manager: CLLocationManager,
		didChangeAuthorization status: CLAuthorizationStatus
	) {
		if status == .authorizedAlways {
			// IS MONITORING AVAILABLE? If yes, then check if Ranging is Available
			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
				if CLLocationManager.isRangingAvailable() {
					// do stuff
				}
			}
		}
	}
}



