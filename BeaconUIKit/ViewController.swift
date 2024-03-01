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
	/// Blank @objc method
	@objc func something() {
		//
	}
	
	// MARK: - FUNCTIONS
	/// Blank function
	func somethingElse() {
		//
	}
	
	/// Location Management Function
	/// - Parameters:
	///   - manager: CoreLocation Manager
	///   - status: is set to Authorized Always
	func locationManager(
		_ manager: CLLocationManager,
		didChangeAuthorization status: CLAuthorizationStatus
	) {
		if status == .authorizedAlways {
			// IS MONITORING AVAILABLE? If yes, then check if Ranging is Available
			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
				if CLLocationManager.isRangingAvailable() {
					startScanning()
				}
			}
		}
	}
	
	/// Sets UUID for scanning beacons
	func startScanning() {
		let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
		let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
		
		locationManager?.startMonitoring(for: beaconRegion)
		locationManager?.startRangingBeacons(in: beaconRegion)
	}
	
	func update(distance: CLProximity) {
		UIView.animate(withDuration: 1) {
			switch distance {
			
			case .far:
				self.view.backgroundColor = .blue
				self.distanceReading.text = "FAR"
				
			case .near:
				self.view.backgroundColor = .orange
				self.distanceReading.text = "NEAR"
				
			case .immediate:
				self.view.backgroundColor = .red
				self.distanceReading.text = "RIGHT HERE"
				
			default:
				self.view.backgroundColor = .gray
				self.distanceReading.text = "UNKOWN"
			}
		}
	}
	
	func locationManager(
		_ manager: CLLocationManager,
		didRangeBeacons beacons: [CLBeacon],
		in region: CLBeaconRegion
	) {
		if let beacon = beacons.first {
			update(distance: beacon.proximity)
		} else {
			update(distance: .unknown)
		}
	}
}



