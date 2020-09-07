//
//  ViewController.swift
//  FireBaseGoogleLogin
//
//  Created by 장우근 on 2020/09/06.
//  Copyright © 2020 pioneerplat. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //뷰 컨트롤러에서 viewDidLoad 메서드를 재정의하여 GIDSignIn 객체의 프레젠테이션 뷰 컨트롤러를 설정하고, 가능한 경우 자동으로 로그인합니다(선택사항).
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    

}

