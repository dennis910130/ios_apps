//
//  ViewController.swift
//  Where Am I
//
//  Created by ChenSi on 7/10/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//
import MapKit
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    var annotation = MKPointAnnotation()
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(manager.location, completionHandler: {
            (places, error) in
            let pm = places[0] as? CLPlacemark
            if (pm != nil) {
                
                var message:String = ""
                message += pm!.subThoroughfare != nil ? pm!.subThoroughfare + " " : ""
                message += pm!.thoroughfare != nil ? pm!.thoroughfare + " " : ""
                message += pm!.subLocality != nil ? pm!.subLocality + " " : ""
                message += pm!.locality != nil ? pm!.locality + " " : ""
                message += pm!.administrativeArea != nil ? pm!.administrativeArea + " " : ""
                message += pm!.postalCode != nil ? pm!.postalCode + " " : ""
                message += pm!.country != nil ? pm!.country + " " : ""
                self.outputLabel.text = message
                self.speedLabel.text = "\(manager.location.speed) mph"
                self.latitudeLabel.text = "\(manager.location.coordinate.latitude)"
                self.longitudeLabel.text = "\(manager.location.coordinate.longitude)"
            }
            else {
                self.outputLabel.text = "Sorry we cannot track your location!"
            }
        })
        let span = MKCoordinateSpanMake(CLLocationDegrees(0.01), CLLocationDegrees(0.01))
        let location = CLLocationCoordinate2DMake(manager.location.coordinate.latitude, manager.location.coordinate.longitude)
        let region = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: true)
        self.annotation.title = "You"
        self.annotation.coordinate = location
        self.annotation.subtitle = "haha"
        self.mapView.addAnnotation(self.annotation)
        
    }
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func goButton(sender: AnyObject) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    @IBAction func stopButton(sender: AnyObject) {
        manager.stopUpdatingLocation()
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

