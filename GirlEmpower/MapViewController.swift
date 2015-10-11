//
//  MapViewController.swift
//  GirlEmpower
//
//  Created by Laura Phelps on 10/1/15.
//  Copyright © 2015 Laura Phelps. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {
    
    let twit = TwitterManager()

    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        twit.getTimeline("acavanagh") { (tweets, error) -> Void in
            
            
            
        }
    
        NSNotificationCenter.defaultCenter().addObserverForName(DidUpdateLocationNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (note) -> Void in
            print(note)
        }
        
        
        LocationManager.currentLocation { (location, error) -> Void in
            print(location)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
        
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
