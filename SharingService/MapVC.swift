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
    let curLocationMarker = NMFMarker()
    let today = Date() //현재 시각 구하기
    let dateFormatter = DateFormatter()
    var detailView = DetailView.instanceFromNib()
    var dateInt: Int = 0
    var reloadData = true
    var shownMarkers = [NMFMarker]()
    var selectedMarker: NMFMarker?
    var buttonType: Int = 0
    
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var supportButton: UIButton!
    
    // MARK: - outlet
    @IBOutlet weak var mapView: NMFMapView!
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaverMapDelegate()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateInt = Int(dateFormatter.string(from: today)) ?? 0
        setDetailView()
        detailView.isHidden = true
        curLocationMarker.iconImage = NMFOverlayImage(name: "location")
        
        OrgScheduleService.shared.getSchedule(1, dateInt){
            data in
            //data 배열은 해당마커를 클릭했을때 나오는 일정들
            for schedule in data {
                
            }
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateLocation()
    }
    @IBAction func goodsBtnClick(_ sender: UIButton) {
        buttonType = 0
        reloadMarkers(coor: locationManager.location!.coordinate)
        goodButton.setBackgroundImage(UIImage(named: "redGoods"), for: .normal)
        supportButton.setBackgroundImage(UIImage(named: "whiteSupport"), for: .normal)
        
    }
    @IBAction func supportBtnClick(_ sender: UIButton) {
        buttonType = 1
        reloadMarkers(coor: locationManager.location!.coordinate)
        goodButton.setBackgroundImage (UIImage(named: "whiteGoods"), for: .normal)
        supportButton.setBackgroundImage(UIImage(named: "redSupport"), for: .normal)
    }
    
    @IBAction func gpsBtnClick(_ sender: Any) {
        reloadData = true
    }
    
}

// MARK: - CLLocationManagerDelegate
extension MapVC: CLLocationManagerDelegate {
    
    func updateLocation(){
        reloadData = true
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
            
            if reloadData {
                reloadData = false
                reloadMarkers(coor: coor)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager,didFailWithError error: Error) {
        //에러 발생
    }
    
    func reloadMarkers(coor: CLLocationCoordinate2D){
        updateCamera(coor.latitude, coor.longitude)
        OrgListService.shared.getList(coor.latitude, coor.longitude, 0) {
            data in
            
            var condition = true
            for m in self.shownMarkers {
                m.mapView = nil
            }
            self.shownMarkers.removeAll()
            
            for i in 0..<data.count {
                switch self.buttonType {
                case 0:
                    condition = data[i].type == 0
                case 1:
                    condition = data[i].type == 1 || data[i].type == 2
                default:
                    break
                }
                if condition{
                    let marker = NMFMarker()
                    self.shownMarkers.append(marker)
                    marker.position = NMGLatLng(lat: data[i].lat, lng: data[i].lon)
                    marker.mapView = self.mapView
                    marker.iconImage = NMFOverlayImage(name: "unselected")
                    
                    marker.touchHandler = { (marker) -> Bool in
                        if let selected = self.selectedMarker {
                            selected.iconImage = NMFOverlayImage(name: "unselected")
                        }
                        (marker as! NMFMarker).iconImage = NMFOverlayImage(name: "selected")
                        self.selectedMarker = (marker as! NMFMarker)
                        self.detailView.isHidden = false
                        self.updateCamera(data[i].lat, data[i].lon, 16)
                        
                        return true
                    }
                }
            }
            return
        }
    }
    
}

// MARK: - NMFMapViewDelegate
extension MapVC: NMFMapViewDelegate {
    func setNaverMapDelegate(){
        self.mapView.delegate = self
    }
    
    // 마커 갱신
    func updateMarker(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees){
        curLocationMarker.position = NMGLatLng(lat: latitude, lng: longitude)
        curLocationMarker.mapView = mapView
    }
    
    // 카메라 위치 갱신
    func updateCamera(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: 13.0)
        cameraUpdate.animation = .easeOut
        mapView.moveCamera(cameraUpdate)
    }
    func updateCamera(_ latitude:CLLocationDegrees , _ longitude: CLLocationDegrees, _ zoom: Double){
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude), zoomTo: zoom)
        cameraUpdate.animation = .easeOut
        mapView.moveCamera(cameraUpdate)
    }
    
    // 지도 탭
    func didTapMapView(_ point: CGPoint, latLng latlng: NMGLatLng) {
        print("지도 탭 \(latlng.lat),\(latlng.lng)")
        if let selected = selectedMarker {
            updateCamera(curLocationMarker.position.lat, curLocationMarker.position.lng)
            selected.iconImage = NMFOverlayImage(name: "unselected")
            
            selectedMarker = nil
        }
        self.detailView.isHidden = true        
    }
    
}

extension MapVC {
    func setDetailView(){
        OperationQueue.main.addOperation {
            // code
            self.detailView.translatesAutoresizingMaskIntoConstraints = false
            
            self.detailView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
                .isActive = true
            self.detailView.topAnchor.constraint(equalTo: self.view.topAnchor)
                .isActive = true
            self.detailView.heightAnchor.constraint(equalToConstant: 318)
                .isActive = true
        }
        self.view.addSubview(detailView)
    }
    
    func putDetailInfo(data: OrgDatas){
        
    }
}
