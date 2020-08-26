//
//  SceneDelegate.swift
//  Chapter03-TabBar
//
//  Created by 장우근 on 2020/08/22.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
       
        
        // 1. 루트 뷰 컨틀로러를 UITabBarController로 캐스팅한다. // 현재의 rootViewController는 탭 바 컨트롤러이다.
        if let tbC = self.window?.rootViewController as? UITabBarController {

            // 2. 탭 바로부터 탭 바 아이템 배열을 가져온다.
            if let tbItems = tbC.tabBar.items {
               /*
                // 3. 탭 바 아이템에 커스텀 이미지를 등록한다.
                // 3.1 이미지 원본을 그대로 가져 오지 않고 랜더링 하여 가져온다. 랜더링을 거치게 되면 원래 색상 정보를 무시하고, 단순히 알파값으로 표시한다.
                tbItems[0].image = UIImage(named: "calendar.png") //확장자 생략가능
                tbItems[1].image = UIImage(named: "file-tree.png")
                tbItems[2].image = UIImage(named: "photo.png")
               */
                
                
                // 3.2 이미지 원본을 그대로 가져 올 때
                tbItems[0].image = UIImage(named: "designbump")?.withRenderingMode(.alwaysOriginal)
                tbItems[1].image = UIImage(named: "rss")?.withRenderingMode(.alwaysOriginal)
                tbItems[2].image = UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal)
                
                // 탭 바 아이템 전체를 순회하면서 selectedImage 속성에 이미지를 설정한다.(활성화되었을때 이미지를 전부 checkmark로 바꾼다.
                for tbItem in tbItems {
                    let image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysOriginal)
                    tbItem.selectedImage = image
                    
                    /*
                    // 탭 바 아이템 별 텍스트 색상 속성을 설정한다.
                    tbItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: UIControl.State.disabled)    //UIControl.State는 명확하게 정의되어있으므로 생략 가능
                    tbItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)    //UIControl.State를 생략하고 .selected로 사용가능
                    
                    // 전체 아이템의 폰트 크기를 설정한다.
                    tbItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                     */
                    }
                    //외형 프록시 객체를 이용하여 아이템의 타이틀 색상과 폰트 크기를 설정한다. 위와 같은 효과 외형프록시는 루프문을 돌지않고 한꺼번에 전체를 설정할 수 있다.
                    let tbItemProxy = UITabBarItem.appearance()
                    tbItemProxy.setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor.red], for: .selected)
                    tbItemProxy.setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIColor.gray], for: .disabled)
                    tbItemProxy.setTitleTextAttributes([NSAttributedString.Key.foregroundColor :UIFont.systemFont(ofSize: 15)], for: .normal)
                    
                
                
                
                // 4. 탭 바 아이템에 타이틀을 설정한다.
                tbItems[0].title = "calender"
                tbItems[1].title = "file"
                tbItems[2].title = "photo"
                
                // 5. 활성화된 탭 바 아이템의 이미지 색상을 변경한다.
                tbC.tabBar.tintColor = UIColor.white    //선택되었을때 컬러
                tbC.tabBar.unselectedItemTintColor = UIColor.gray   //선택되지 않았을때 컬러
                
                // 6. 탭 바에 배경 이미지를 설정한다.
                tbC.tabBar.backgroundImage = UIImage(named: "menubar-bg-mini")
                //let image = UIImage(named: "menubar-bg-mini")!        //배경 패턴화
                //tbC.tabBar.barTintColor = UIColor(patternImage: image)//패턴화된 이미지 사용
                //tbC.tabBar.barTintColor = UIColor.black //배경 검정으로
                
            }
        }
             
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

