//
//  ViewController.swift
//  Chapter02-Button
//
//  Created by 장우근 on 2020/08/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    

        /*
        버튼을 화면에 추가하는 과정.
        1 버튼의 인스턴스를 생성한다.
        2 버튼이 표현될 영역을 정의한다.
        3 버튼의 속성을 설정한다.
        4 버튼을 루트 뷰에 추가한다.
         */
        
        // 버튼 인스턴스를 생성하고, 속성을 설정한다.
        let btn = UIButton(type: UIButton.ButtonType.system)            //1
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)   //2
        btn.setTitle("테스트 버튼", for: UIControl.State.normal)       //3
        
        //버튼을 수평 중앙 정렬한다.
        //.center 속성은 객체의 중심 좌표를 지정하는 역할
        btn.center = CGPoint(x: self.view.frame.size.width / 2, y: 100)
        
        //루트 뷰에 버튼을 추가한다.
        self.view.addSubview(btn)
        
        //버튼의 이벤트와 메소드 btnOnclick(_:)을 연결한다.
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
    }
    //사용자가 버튼을 터치했을 때 반응할 액션 메소드.
    @objc func btnOnClick(_ sender: Any) {
        // 호출한 객체가 버튼이라면
        if let btn = sender as? UIButton {
            btn.setTitle("클릭되었습니다.", for: UIControl.State.normal)
        }
    }
}

