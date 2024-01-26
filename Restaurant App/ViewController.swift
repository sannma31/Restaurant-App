//
//  ViewController.swift
//  Restaurant App
//
//  Created by 笠井翔雲 on 2024/01/23.
//
import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var Gps: UIButton!
    @IBOutlet weak var Map: MKMapView!
    @IBOutlet weak var label: UILabel!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupMapView()
        label.text = "レストラン検索アプリ"
    }

    private func setupMapView() {
        Map.delegate = self
        Map.showsUserLocation = true
    }

    @IBAction func showMyLocationAction(_ sender: Any) {
        locationManager.requestLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("reverseGeocodeLocation Failed: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                var locationInformation = ""
                locationInformation += "Latitude: \(location.coordinate.latitude)\n"
                locationInformation += "Longitude: \(location.coordinate.longitude)\n\n"
                locationInformation += "Country: \(placemark.country ?? "")\n"
                locationInformation += "State/Province: \(placemark.administrativeArea ?? "")\n"
                locationInformation += "City: \(placemark.locality ?? "")\n"
                locationInformation += "PostalCode: \(placemark.postalCode ?? "")\n"
                locationInformation += "Name: \(placemark.name ?? "")"
                print(locationInformation)
            }
        }

        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        Map.setRegion(coordinateRegion, animated: true)

        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = "ここにいるよ!"
        pointAnnotation.coordinate = location.coordinate

        print("location: \(location)")
        print("緯度: \(location.coordinate.latitude)")
        print("経度: \(location.coordinate.longitude)")

        Map.removeAnnotations(Map.annotations)
        Map.addAnnotation(pointAnnotation)
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
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
