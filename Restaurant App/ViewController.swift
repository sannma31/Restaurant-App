//
//  ViewController.swift
//  Restaurant App
//
//  Created by 笠井翔雲 on 2024/01/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            locationManager.delegate = self // CLLocationManagerDelegateプロトコルを使用するためにdelegateをViewControllerクラスに設定する。
            locationManager.requestWhenInUseAuthorization() // 位置情報の許可設定を通知する。
            locationManager.requestLocation() // 1度だけ位置情報取得のリクエストを投げる。
        }
    

    @IBAction func tappbutton(_ sender: Any) {
        locationManager.requestLocation()
        print("タップされました")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                print("location: \(location)") // CLLocationManagerクラスで取得した位置情報
                print("緯度: \(location.coordinate.latitude)")
                print("経度: \(location.coordinate.longitude)")
            }
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error: \(error)")
        }
    
}

