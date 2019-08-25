//
//  LocationViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/23.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import MapKit
import FirebaseFirestore

class LocationViewController: UIViewController {
    // ロケーション関連
    var locationManager: CLLocationManager!
    // firebase
    let db = Firestore.firestore()
    
    @IBOutlet weak var mapView: MKMapView!
    
    // ロングタップしたときに立てるピンを定義
    var pinByLongPress: MKPointAnnotation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自分の位置
        let myLocationManager = CLLocationManager()
        myLocationManager.requestWhenInUseAuthorization()
        
        fech()
        
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        print("longPress")
        //ロングタップの最初の感知のみ受け取る
        if(sender.state != UIGestureRecognizer.State.began){
            return
        }
        //インスタンス化
        pinByLongPress = MKPointAnnotation()
        
        //ロングタップから位置情報を取得
        let location:CGPoint = sender.location(in: mapView)
        
        //取得した位置情報をCLLocationCoordinate2D（座標）に変換
        let longPressedCoordinate: CLLocationCoordinate2D = mapView.convert(location, toCoordinateFrom: mapView)
        print("longPressedCoordinate:\(longPressedCoordinate)")
        
        //ロングタップした位置の座標をピンに入力
        pinByLongPress.coordinate = longPressedCoordinate
        
        //ピンを追加する（立てる）
        mapView.addAnnotation(pinByLongPress)
        
        // 保存
        firebaseSave(location: longPressedCoordinate)
        
    }
    func firebaseSave(location: CLLocationCoordinate2D) {
        var ref: DocumentReference? = nil
        ref = db.collection("mapLocation").addDocument(data: [
            "latitude": location.latitude,
            "longitude": location.longitude,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func fech() {
        db.collection("mapLocation").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dict = document.data() as Dictionary
                    guard let latitude = dict["latitude"], let longitude = dict["longitude"] else {
                        print("辞書変換失敗")
                        return
                    }
                    
                    guard let moge = latitude as? Double,
                        let koge = longitude as? Double else {
                            print("double 変換失敗")
                            return
                    }
                    //インスタンス化
                    self.pinByLongPress = MKPointAnnotation()
                    let location = CLLocationCoordinate2D(latitude: moge, longitude: koge)
                    self.pinByLongPress.coordinate = location
                    self.mapView.addAnnotation(self.pinByLongPress)
                }
            }
        }
    }
    
    // 前の画面に戻る
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        fech()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("ユーザーはこのアプリケーションに関してまだ選択を行っていません")
        // 許可を求めるコードを記述する（後述）
        case .denied:
            print("ローケーションサービスの設定が「無効」になっています (ユーザーによって、明示的に拒否されています）")
        // 「設定 > プライバシー > 位置情報サービス で、位置情報サービスの利用を許可して下さい」を表示する
        case .restricted:
            print("このアプリケーションは位置情報サービスを使用できません(ユーザによって拒否されたわけではありません)")
        // 「このアプリは、位置情報を取得できないために、正常に動作できません」を表示する
        case .authorizedAlways:
            print("常時、位置情報の取得が許可されています。")
        // 位置情報取得の開始処理
        case .authorizedWhenInUse:
            print("起動時のみ、位置情報の取得が許可されています。")
        // 位置情報取得の開始処理
        @unknown default:
            print("しらん")
        }
    }
}
