//
//  ViewController.swift
//  GetLocation
//
//  Created by Tim 20/05/2019.
//

import Foundation
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    @IBOutlet var label : UILabel!
    var manager: CLLocationManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager = CLLocationManager()
        manager?.delegate = self
        manager?.desiredAccuracy = kCLLocationAccuracyBest
        manager?.requestWhenInUseAuthorization()
        manager?.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first  else {
            return
        }
        getAddressFromLatLon("\(first.coordinate.longitude)","\(first.coordinate.latitude)")
        label.text = "Kinh độ: \(first.coordinate.longitude) \nVĩ độ: \(first.coordinate.latitude) \n "
//        getAddressFromLatLon("10.850131", "106.787475")
    }
}

extension ViewController{
    func getAddressFromLatLon(_ longitude: String,_ latitude: String) -> String {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        
        center.latitude = Double("\(latitude)")!
        center.longitude = Double("\(longitude)")!
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler: { (placemarks, error) in
            if (error != nil)
            {
                print("Reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks! as [CLPlacemark]
            
            if pm.count > 0 {
                let pm = placemarks![0]
                let name = pm.name ?? ""
                let street = pm.thoroughfare ?? ""
                let ward = pm.subLocality ?? ""
                let city = pm.locality ?? ""
                let country = pm.country ?? ""
                let address = name + "," + street  + "," + ward   + "," + city  + "," + country
                print ("\(name), \(street), \(ward), \(city), \(country)")
            }
        })
        return "abc"
    }
    
}

