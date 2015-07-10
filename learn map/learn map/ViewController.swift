//
//  ViewController.swift
//  learn map
//
//  Created by ChenSi on 7/10/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(38.041144), CLLocationDegrees(114.515520))
        var span : MKCoordinateSpan = MKCoordinateSpanMake(CLLocationDegrees(0.1), CLLocationDegrees(0.1))
        var region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }

    @IBOutlet weak var mapView: MKMapView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

