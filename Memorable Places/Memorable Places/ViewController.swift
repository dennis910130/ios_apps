//
//  ViewController.swift
//  Memorable Places
//
//  Created by ChenSi on 7/11/15.
//  Copyright (c) 2015 ChenSi. All rights reserved.
//

import UIKit
import MapKit

var realCoord:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var lpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        lpgr.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(lpgr)
        for place in places {
            let newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = place.location
            newAnnotation.title = place.name
            newAnnotation.subtitle = place.memo
            mapView.addAnnotation(newAnnotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func action(longPressGestureRecognizer:UILongPressGestureRecognizer) {
        if (longPressGestureRecognizer.state == UIGestureRecognizerState.Began) {
            var touchPoint = longPressGestureRecognizer.locationInView(mapView)
            realCoord = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
            let addViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddViewController") as AddViewController
            self.navigationController?.pushViewController(addViewController, animated: true)
        }
    }


}

