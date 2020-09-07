//
//  ViewController.swift
//  KingPleTalk
//
//  Created by 장우근 on 2020/09/08.
//  Copyright © 2020 pioneerplat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseRemoteConfig
import SnapKit

class ViewController: UIViewController {

    var box = UIImageView()
    var remoteConfig : RemoteConfig!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        self.view.addSubview(box)
        box.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)  //  view의 center로 가도록
        }
        box.image = #imageLiteral(resourceName: "loading_icon")
        self.view.backgroundColor = UIColor(hex: "#000000ff")
        //self.view.backgroundColor = UIColor(red: 0.9, green: 0.3, blue: 0.5, alpha: 1)
       
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        // 서버가 연결이 되이 않았을때 기본값
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        //TimeInterval 0을 넣게되면 앱을 킬때 마다 요청, 3600을 넣으면 1시간 마다 요청
        remoteConfig.fetch(withExpirationDuration: TimeInterval(0)) { (status, error) -> Void in
          if status == .success {
            print("Config fetched!")
            //요청이 성공 되었을 때 activate()되어서 서버값이 적용
            self.remoteConfig.activate() { (changed, error) in
              // ...
            }
          } else {
            //요청이 실패 했을때
            print("Config not fetched")
            print("Error: \(error?.localizedDescription ?? "No error available.")")
          }
          self.displayWelcome()
        }
    }
    func displayWelcome() {
        let color = remoteConfig["splash_background"].stringValue
        let caps = remoteConfig["splash_message_caps"].boolValue
        let message = remoteConfig["splash_message"].stringValue
        
        print("\(color)")
        self.view.backgroundColor = UIColor(hex: color!)
        // caps값이 true면 앱이 원격으로 꺼지도록 설정
        if(caps){
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { (action) in
                exit(0) //exit(0)을 실행하면 앱이 종료
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }


}

//UIColor에서 16진수 코드 사용하기
//swift hex를 검색하여 https://crunchybagel.com/working-with-hex-colors-in-swift-3/


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
/*
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        //scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
 */
