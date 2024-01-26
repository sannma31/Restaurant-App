//
//  ViewController.swift
//  Restaurant App
//
//  Created by 笠井翔雲 on 2024/01/23.
//
import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var Map: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("location: \(location)")
            print("緯度: \(location.coordinate.latitude)")
            print("経度: \(location.coordinate.longitude)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager failed with error: \(error.localizedDescription)")
        // ここでエラーに対する適切な処理を追加する
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            startUpdatingLocation()
        default:
            break
        }
    }
}
