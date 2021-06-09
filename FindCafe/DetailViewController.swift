//
//  DetailViewController.swift
//  FindCafe
//
//  Created by 粘辰晧 on 2021/6/9.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var latitude = 0.0
    var longitude = 0.0
    var cafeData: CafeInfo?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cafeName: UILabel!
    @IBOutlet weak var cafeAddress: UILabel!
    @IBOutlet weak var openTime: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let cafeData = cafeData {
            latitude = Double(cafeData.latitude)!
            longitude = Double(cafeData.longitude)!
            
            cafeName.text = cafeData.name
            cafeAddress.text = cafeData.address
            openTime.text = "\(cafeData.open_time)"
        }
        
        settingCafeAnnotation()
        
        print(latitude)
        print(longitude)
        //設定目標
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func navv(_ sender: Any) {
        map()
        
    }
    
    func settingCafeAnnotation() {
        let studioAnnotation = MKPointAnnotation()
        studioAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        // 設置大頭針標題
        studioAnnotation.title = cafeData?.name
        // 設置大頭針副標題，需點選才能看見
        studioAnnotation.subtitle = cafeData?.address
        
        mapView.setCenter(studioAnnotation.coordinate, animated: true)
        // 更改當前可見區域，並且根據指定的坐標和距離值創建新的MKCoordinateRegion。
        mapView.setRegion(MKCoordinateRegion(center: studioAnnotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200), animated: true)
        mapView.addAnnotation(studioAnnotation)
    }
    
    func map() {
        if let cafeData = cafeData {
            latitude = Double(cafeData.latitude)!
            longitude = Double(cafeData.longitude)!
            
            cafeName.text = cafeData.name
            cafeAddress.text = cafeData.address
            openTime.text = "\(cafeData.open_time)"
        }
        print(latitude)
        print(longitude)
        
        let targetLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //初始化使用MKPlacemark
        let targetPlacemark = MKPlacemark(coordinate: targetLocation)
        let targetItem = MKMapItem(placemark: targetPlacemark)
        
        let userMapItem = MKMapItem.forCurrentLocation()
        print(userMapItem)
        
        let routes = [userMapItem, targetItem]
        MKMapItem.openMaps(with: routes, launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
        
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
