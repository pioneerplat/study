//
//  AppDelegate.swift
//  HowFireBaseLogin
//
//  Created by 장우근 on 2020/09/05.
//  Copyright © 2020 pioneerplat. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        // Use Firebase library to configure APIs
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    //firebase - 앱 대리자의 application:openURL:options: 메서드를 구현합니다. 이 메서드는 GIDSignIn 인스턴스의 handleURL 메서드를 호출하여 인증 프로세스가 끝날 때 애플리케이션이 수신하는 URL을 적절히 처리합니다.
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    //firebase - 앱을 iOS 8 이상에서 실행하려면 지원이 중단된 application:openURL:sourceApplication:annotation: 메서드도 구현합니다.
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    //firebase - 앱 대리자에서 GIDSignInDelegate 프로토콜을 구현하고 다음의 메서드를 정의하여 로그인 프로세스를 처리합니다.
    //회원가입하고 넘어가는 부분
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }
    // GoogleAuthPrivider 인증된 토큰이 넘어 오는 단계
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
      // ...
        // Firebase 사용자 인증 정보를 사용해 Firebase에 인증
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                // ...
            }
                return
            }
        
        
        
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    // MARK: UISceneSession Lifecycle

  

    


}

