//
//  ViewController.swift
//  Chapter02-InputForm
//
//  Created by 장우근 on 2020/08/22.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //상수가 아닌 변수를 사용하는 것은 클래스 레벨에서 선언하면서 초기화와 분리된 결과로 이해
    //입력용 컨트롤
    var paramEmail: UITextField! // 이메일 입력 필드
    var paramUpdate: UISwitch! // 스위치 객체
    var paramInterval: UIStepper! // 스테퍼
    
    //출력용 레이블
    var txtUpdate: UILabel! // 스위치 컨트롤의 값을 표현할 레이블
    var txtInterval: UILabel! // 스테퍼 컨트롤의 값을 표현할 레이블
    
    override func viewDidLoad() {
        //1. 네비게이션 바 타이틀을 입력한다.
        self.navigationItem.title = "설정"
        
        //2. 이메일 레이블을 생성하고 영역과 기본 문구를 설정한다.
        let lblEmail = UILabel()
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        
        //3. 레이블의 폰트를 설정한다.
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        //lblEmail.font = UIFont(name: "Chalkboard SE", size: 14) //폰트이름과 폰트크기 같이 선언
        
        //4. 레이블을 루트 뷰에 추가한다.
        self.view.addSubview(lblEmail)
        
        /* //지원하는 폰트 패밀리 목록 출력
        let fonts = UIFont.familyNames
        for f in fonts {
            print("\(f)")
        }
        */
        
        /* //폰트 패밀리에 속한 폰트를 모두 출력(이 값을 UIFont(name:size:)에 넣으면 그 폰트를 적용할 수 있다.
        let fonts = UIFont.fontNames(forFamilyName: "Menlo")
        for f in fonts {
            print("\(f)")
        }
        */
        
        // 자동갱신 레이블을 생성하고 루트 뷰에 추가한다.
        let lblUpdate = UILabel()
        lblUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblUpdate)
        
        // 갱신주기 레이블을 생성하고 루트 뷰에 추가한다.
        let lblInterval = UILabel()
        lblInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lblInterval)
        
        //이메일 입력을 위한 텍스트 필드를 추가한다.
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = UITextField.BorderStyle.roundedRect
        self.paramEmail.autocapitalizationType = .none // 대문자 자동 변환 기능을 해제한느 구문
        self.view.addSubview(self.paramEmail)
    
        //스위치 객체를 생성한다.
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        //스위치가 On 되어 있는 상태를 기본값으로 설정한다.
        self.paramUpdate.setOn(true, animated: true)
        self.view.addSubview(self.paramUpdate)
        
        //갱신주기를 위한 스테퍼를 추가한다.
        self.paramInterval = UIStepper()
        
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0     // 1. 스테퍼가 가질 수 있는 최소값
        self.paramInterval.maximumValue = 100   // 2. 스테퍼가 가질 수 있는 최대값
        self.paramInterval.stepValue = 1        // 3. 스테퍼의 값 변경 단위
        self.paramInterval.value = 0            // 4. 초기값 설정
        self.view.addSubview(self.paramInterval)
        
        //스위치 객체의 값을 표현할 레이블을 추가한다.
        self.txtUpdate = UILabel()
        self.txtUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        self.txtUpdate.font = UIFont.systemFont(ofSize: 12)
        self.txtUpdate.textColor = UIColor.red  // 1. 텍스트의 색상 설정
        self.txtUpdate.text = "갱신함"            // 2. "갱신함" or "갱신하지 않음"
        self.view.addSubview(self.txtUpdate)
        
        //스테퍼의 값을 텍스트로 표현할 레이블을 추가한다.
        self.txtInterval = UILabel()
        self.txtInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.txtInterval.font = UIFont.systemFont(ofSize: 12)
        self.txtInterval.textColor = UIColor.red
        self.txtInterval.text = "0분마다"
        self.view.addSubview(self.txtInterval)
        
        
        //스위치와 스테퍼 컨트롤의 Value Changed 이벤트를 각각 액션 메소드에 연결한다.
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
        
        // 전송 버튼을 내비게이션 아이템에 추가하고, submit 메소드에 연결한다.
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        self.navigationItem.rightBarButtonItem = submitBtn
        
        
    }
    // 스위치와 상호반응할 액션 메소드
    @objc func presentUpdateValue(_ sender: UISwitch) {
        self.txtUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    // 스테퍼와 상호반응할 액션 메소드
    @objc func presentIntervalValue(_ sender: UIStepper) {
        self.txtInterval.text = ("\( Int(sender.value))분마다")
    }

    // 전송 버튼과 상호반응할 액션 메소드
    @objc func submit(_ sender: Any) {
        let rvc = ReadViewController()
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
}

