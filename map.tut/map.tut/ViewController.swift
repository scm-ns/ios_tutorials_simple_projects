//
//  ViewController.swift
//  map.tut
//
//  Created by scm197 on 10/18/16.
//  Copyright © 2016 scm197. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController , MKMapViewDelegate
{
    var defaultZoom: CLLocationDistance  = 2000 ;
    
    @IBOutlet weak var zoomButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchText: UITextField!
    var matchingItems: [MKMapItem] = [MKMapItem]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.delegate = self

      
        // Add the circle overlay and see how that works
        self.addOverlay()
        
    }

    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
    {
            let circleRender : MKCircleRenderer = MKCircleRenderer(overlay: overlay)
            
            circleRender.fillColor = UIColor.redColor()
        
            return circleRender
    }
    
    func addOverlay()
    {
        let fenceDist : CLLocationDistance = 300 ;
        let delta : CLLocationDegrees = 0.01 ;
       
        let circleCenter : CLLocationCoordinate2D = CLLocationCoordinate2DMake(mapView.userLocation.coordinate.latitude + delta, mapView.userLocation.coordinate.longitude + delta)
        
        let circleOver : MKCircle = MKCircle(centerCoordinate: circleCenter, radius: fenceDist)
       
       
        mapView.addOverlay(circleOver)
        
    }
    

    @IBAction func zoomIn(sender: AnyObject)
    {
        let userLoc = mapView.userLocation
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let region = MKCoordinateRegionMakeWithDistance((userLoc.location?.coordinate)!, defaultZoom, defaultZoom)
       
        if(defaultZoom > 0)
        {
            mapView.setRegion(region, animated: true)
            defaultZoom -= 100 ;
        }
        else // disable the button
        {
            zoomButton.enabled = false
        }
    }
    
    @IBAction func changeType(sender: AnyObject)
    {
        switch mapView.mapType {
        case MKMapType.Standard:
            mapView.mapType = MKMapType.Satellite
        case MKMapType.Satellite:
            if #available(iOS 9.0, *)
            {
                mapView.mapType = MKMapType.SatelliteFlyover
                print("flyover")
            }
            else
            {
                mapView.mapType = MKMapType.Standard
            }
        case MKMapType.SatelliteFlyover:
            mapView.mapType = MKMapType.Standard
        default:
            mapView.mapType = MKMapType.Standard
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation)
    {
        mapView.centerCoordinate = (userLocation.location?.coordinate)!
    }
   
   
    @IBAction func textFeildReturn(sender: AnyObject)
    {
       sender.resignFirstResponder()
       mapView.removeAnnotations(mapView.annotations)
       self.performSearch()
    }
    
    
    func performSearch()
    {
   
            matchingItems.removeAll()
            let request = MKLocalSearchRequest()
            request.naturalLanguageQuery = searchText.text
            request.region = mapView.region
        
       
            let search = MKLocalSearch(request: request)
    
            search.startWithCompletionHandler()
                {
                    (response: MKLocalSearchResponse? , err : NSError?) in
                    if let response = response
                    {
                      //  guard err != nil where response.mapItems.count >= 0 else { print("error") ; return}
                        
                        
                    }
                
                }
                
                
        
    }
        
    
    
}

