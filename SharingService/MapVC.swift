//
//  ViewController.swift
//  SharingService
//
//  Created by 임수현 on 01/06/2019.
//  Copyright © 2019 AngelhackSeoul2019. All rights reserved.
//

import UIKit
import NMapsMap

class MapVC: UIViewController {

    // MARK: - instances
    let locationManager = CLLocationManager()
    let marker = NMFMarker()
    
    // MARK: - outlet
    @IBOutlet weak var mapView: NMFMapView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaverMapDelegate()
    }

    override func viewDidAppear(_ animated: Bool) {
        updateLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension MapVC: CLLocationManagerDelegate {
    
    func updateLocation(){
        self.locationManager.delegate = self                  // 뷰 컨트롤러를 로케이션 매니저 객체에 대한 앱델리게이트로 선언
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest  // 정확도 : 최고
        self.locationManager.requestWhenInUseAuthorization()  // 위치 정보 권한 허가 요청
        self.locationManager.startUpdatingLocation()          // 위치 정보 갱신 시작
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //위치가 업데이트될때마다
        if let coor = manager.location?.coordinate{
            print("latitude" + String(coor.latitude) + "/ longitude" + String(coor.longitude))
            
            updateMarker(coor.latitude, coor.longitude)
            updateCamera(coor.latitude, coor.longitude)
            OrgListService.shared.getList(coor.latitude, coor.longitude, 0) {
                data in
                // data 배열을 가지고 지도에 mapping 하는 기능
                return
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error) {
        //에러 발생
    }
}

// MARK: - NMFMapViewDelegate
extension MapVC: NMFMapViewDelegate {
    func setNaverMapDelegate(){
        self.mapView.delegate = self
    }
    
    // 마커 갱신
    func updateMarker(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees){
        marker.position = NMGLatLng(lat: latitude, lng: longitude)
        marker.mapView = mapView
    }
    
    // 카메라 위치 갱신
    func updateCamera(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 16.0)
        mapView.moveCamera(cameraUpdate)
    }
    func updateCamera(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees, _ zoom: Double){
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: zoom)
        mapView.moveCamera(cameraUpdate)
    }
    
    // 지도 탭
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        print("지도 탭 \(latlng.lat),\(latlng.lng)")
    }
}
