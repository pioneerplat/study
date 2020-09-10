//
//  LoginViewController.swift
//  KingPleTalk
//
//  Created by 장우근 on 2020/09/11.
//  Copyright © 2020 pioneerplat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signIn: UIButton!
    
    //이건 아마 ViewController에서 선언해 놓은 remoteConfig를 가져오는 거인듯
    let remoteConfig = RemoteConfig.remoteConfig()
    //var remoteConfig : RemoteConfig!
    
    var color : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBar = UIView()
        self.view.addSubview(statusBar)
        statusBar.snp.makeConstraints { (m) in
            m.right.top.left.equalTo(self.view) //right,top,left를 뷰와 맞춘다.
            m.height.equalTo(20)    //높이는 20
        }
        
        color = remoteConfig["splash_background"].stringValue
        
        statusBar.backgroundColor = UIColor(hex: color)
        loginButton.backgroundColor = UIColor(hex: color)
        signIn.backgroundColor = UIColor(hex: color)
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
