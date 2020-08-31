//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by 장우근 on 2020/08/30.
//  Copyright © 2020 pioneerplat. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{
   
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    // 피커 뷰에 계정 목록이 표시되도록 더미 데이터 배열을 정의
    var accountlist = ["sqlpro@naver.com", "webmaster@rubypaper.co.kr", "abc1@gmail.com", "abc2@gmail.com", "abc3@gmail.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = UIPickerView() //피커뷰 인스턴스 생성
        // 1 피커 뷰의 델리게이트 객체 지정
        picker.delegate = self
        // 2 account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        self.account.inputView = picker
        
        // 툴 바 객체 정의
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = UIColor.lightGray
        
        // 액세서리 뷰 영역에 툴 바를 표시
        self.account.inputAccessoryView = toolbar
        
        // 툴 바에 들어갈 닫기 버튼 (툴바에 사용된 버튼은 UIBarButtonItem)
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        // 버튼을 툴 바에 추가
        //toolbar.setItems([done], animated: true)
        
        // STEP 1) 가변 폭 버튼 정의
        // 가변폭은 버튼 객체라기보다 말 그대로 가변폭을 담당한다
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        // 버튼을 툴 바에 추가
        //toolbar.setItems([flexSpace, done], animated: true)
        
        // STEP 1) 신규 계정 등록 버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        // 버튼을 툴 바에 추가
        toolbar.setItems([new, flexSpace, done], animated: true)
        
        // 기본 저장소 객체 불러오기
        let plist = UserDefaults.standard
        
        // 불러온 값을 설정
        self.name.text = plist.string(forKey: "name")                       // 이름
        self.married.isOn = plist.bool(forKey: "married")                   // 결혼여부
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")  // 성별
        
        // 1. "accountlist"키로 저장된 값을 읽어온다. 저장된 값이 없을 경우 새로운 배열 객체를 생성
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        // 2. 읽어온 값을 멤버 변수 self.accountlist에 대입
        self.accountlist = accountlist
        // 3. "selectedAccount" 키로 저장된 값을 읽어온다
        // 4. 값이 있을 경우 account 텍스트 필드의 값으로 대입
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
        }
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0이면 남자, 1이면 여자
        let plist = UserDefaults.standard       // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "gender")      // "gender"라는 키로 값을 저장한다.
        plist.synchronize()                     // 동기화 처리
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn                 // true면 기혼, false면 미혼
        
        let plist = UserDefaults.standard       // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "married")     // "married"라는 키로 값을 저장한다.
        plist.synchronize()                     // 동기화 처리
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 두 번째 셀이 클릭되었을 때에만 입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
        if indexPath.row == 1 {
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: UIAlertController.Style.alert)
            //입력 필드 추가
            alert.addTextField(configurationHandler: {
                // name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
                $0.text = self.name.text
            })
            
             // 버튼 및 액션 추가
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                (_) in
                // 사용자가 OK 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
                let value = alert.textFields?[0].text
                
                let plist = UserDefaults.standard       // 기본 저장소를 가져온다.
                plist.setValue(value, forKey: "name")   // "name"이라는 키로 값을 저장한다.
                plist.synchronize()                     // 동기화 처리
                
                self.name.text = value
                
                // 알림창을 띄움
                self.present(alert, animated: false, completion: nil)
                
            }))
        }
        
       
        
    }
    
    
    @objc func pickerDone(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func newAccount(_ sender: Any) {
        // 일단 열려있는 입력용 뷰부터 닫아준다.
        self.view.endEditing(true)
        
        // 알림창 객체 생성
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        // 입력폼 추가
        alert.addTextField() {
            $0.placeholder = "ex) abc@email.com"
        }
        
        // 버튼 및 액션 정의
        /*
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {(_) in
            if let account = alert.textFields?[0].text {
                // 계정 목록 배열에 추가한다.
                self.accountlist.append(account)
                // 계정 텍스트 필드에 표시한다.
                self.account.text = account
            }
        })
        */
        //위의 구문과 같은 구문
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_) in
            if let account = alert.textFields?[0].text {
                // 계정 목록 배열에 추가한다.
                self.accountlist.append(account)
                // 계정 텍스트 필드에 표시한다.
                self.account.text = account
                
                
                //UserDefaults 객체를 이용하여 데이터를 저장하는 과정. accountlist배열을 통째로 저장, 저장용 키는 "accountlist"
                // 계정 목록을 통째로 저장한다.
                let plist = UserDefaults.standard
                
                plist.set(self.accountlist, forKey: "accountlist")
                // 사용자가 신규 계정을 등록했을 때, 그 계정값을 받아 selectedAccount 키로 저장하는 내용
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
            }
        }))
        
        //알림창 오픈
        self.present(alert, animated: false, completion: nil)
        
        // 컨트롤 값을 모두 초기화한다.
        self.name.text = ""
        self.gender.selectedSegmentIndex = 0
        self.married.isOn = false
    }
    
    // 생성할 컴포넌트의 개수를 정의
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
    // 지정된 컴포넌트가 가질 목록의 길이를 정의
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
       }
  
    // 지정된 컴포넌트의 목록 각 행에 출력될 내용을 정의
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    
    // 지정된 컴포넌트의 목록 각 행을 사용자가 선택했을 때 실행할 액션을 정의
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 1 선택된 계정값을 텍스트 필드에 입력
        let account = self.accountlist[row] // 선택된 계정
        self.account.text = account
        
        // 2 입력 뷰를 닫음
        //self.view.endEditing(true)    자동으로 창이 닫는걸 막고 버튼으로 선택과 닫기가 되도록 주석처리
        
        // 사용자가 피커 뷰를 통해 계정을 변경했을 떄, 그 계정값을 받아 selectedAccount라는 키로 저장
        // 사용자가 계정을 생성하면 이 계정을 선택한 것으로 간주하고 저장
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }
    
    

}
