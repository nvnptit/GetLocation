//
//  ViewController.swift
//  GetLocation
//
//  Created by Nhat on 20/05/2022.
//

import Foundation
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate{
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
        label.text = "Kinh độ: \(first.coordinate.longitude) \nVĩ độ: \(first.coordinate.latitude) \n "
    }
}


