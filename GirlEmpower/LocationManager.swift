//
//  LocationManager.swift
//  GirlEmpower
//
//  Created by Laura Phelps on 10/3/15.
//  Copyright © 2015 Laura Phelps. All rights reserved.
//

import Foundation
import CoreLocation

internal let DidUpdateLocationNotification = "DidUpdateLocationNotification"

typealias LocationCompletionBlock = (location: CLLocation?, error: NSError?) -> Void

final class LocationManager : NSObject {
 
    private var currentLocation: CLLocation?
    
    private var completionHandlers = [LocationCompletionBlock?]()
    
    private let locationManager = CLLocationManager()
    private static let _locationManager = LocationManager()
    private override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
    }
    
    private func authorized() -> Bool {
        
        print(CLLocationManager.authorizationStatus().rawValue)
        
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            return true
        case .Restricted, .Denied:
            print("RESTRICTED OR DENIED!")
            // FIXME: DO WE HANDLE THIS HERE SOMEHOW -- SHOW AN ALERT PERHAPS
            return false
        case .NotDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
        }
    }
    
    private func getLocation() {
        if authorized() {
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    private func notifyBlockObservers(error: NSError? = nil) {
        if let currentLocation = currentLocation {
            for completionHandler in completionHandlers {
                completionHandler?(location: currentLocation, error: nil)
            }
            completionHandlers.removeAll()
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopMonitoringSignificantLocationChanges()
        currentLocation = locations.last
        
        notifyBlockObservers()
        
        if let currentLocation = currentLocation {
            NSNotificationCenter.defaultCenter().postNotificationName(DidUpdateLocationNotification, object: currentLocation)
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways {
            getLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        notifyBlockObservers(error)
    }
    
}

// MARK: - Public Interface

extension LocationManager {
    
    class func currentLocation(completion: LocationCompletionBlock? = nil) {
        if let completion = completion {
            _locationManager.completionHandlers.append(completion)
        }
        _locationManager.getLocation()
    }
    
}


