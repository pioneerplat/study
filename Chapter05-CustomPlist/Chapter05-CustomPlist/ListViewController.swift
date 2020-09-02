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
        if let account = plist.string(forKey: "selectedAccount") {  // 1 선택된 계정에 대한 커스텀 프로퍼티 파일을 읽어와 세팅한다.
            self.account.text = account
            
          
            let customplist = "\(account).plist"    // 읽어올 파일명
            // 2 앱 내에 정의된 문서 디렉터리 경로를 가져온 다음, 파일명을 조합하여 전체 경로를 구성한다.
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customplist]).first!
            // 3 저장된 파일을 읽어와서 딕셔너리 객체로 전환한다.
            let data = NSDictionary(contentsOfFile: clist)
            // 4 "name" 키에 저장된 값을 꺼내어 이름 레이블에 세팅한다.
            self.name.text = data?["name"] as? String
            // 5 "gender" 키에 저장된 값을 꺼내어 세그먼트 컨트롤에 세팅한다. 만약 값이 없다면 0으로 설정한다.
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            // 6 "married" 키에 저장된 값을 꺼내어 스위치 컨트롤에 세팅한다. 만약 값이 없다면 false로 설정한다.
            self.married.isOn = data?["married"] as? Bool ?? false
            
            
            // 사용자 계정의 값이 비어 있다면 값을 설정하는 것을 막는다.
            if (self.account.text?.isEmpty)! {
                self.account.placeholder = "등록된 계정이 없습니다."
                self.gender.isEnabled = false
                self.married.isEnabled = false
            }
        }
        
        // 내비게이션 바에 newAccount 메소드와 연결된 버튼을 추가한다.
        let addBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0이면 남자, 1이면 여자
        
        // STEP 8) 저장 로직 시작
        let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        
        data.setValue(value, forKey: "gender")
        data.write(toFile: plist, atomically: true)
        
        
        /* //세그먼트 컨트롤의 값 변화에 반응하도록 설정됨
        let plist = UserDefaults.standard       // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "gender")      // "gender"라는 키로 값을 저장한다.
        plist.synchronize()                     // 동기화 처리
        */
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn                 // true면 기혼, false면 미혼
    
        // STEP 10) 저장 로직 시작
        let customPlist = "\(self.account.text!).plist"  // 읽어올 파일명
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        
        data.setValue(value, forKey: "married")
        data.write(toFile: plist, atomically: true)
        
        // 값이 제대로 저장되었는지 확인
        print("custom plist = \(plist)")
        
        /*
        let plist = UserDefaults.standard       // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "married")     // "married"라는 키로 값을 저장한다.
        plist.synchronize()                     // 동기화 처리
        */
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 두 번째 셀이 클릭되었을 때에만 입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
        //0이 아니라 1, 계정정보가 비어있지 않을때만 if문을 실행
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! {
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
                
                // STEP 6) 저장 로직 시작
                // 현재 입력된 계정을 바탕으로 읽어올 커스텀 프로퍼티 파일명을 정의. 계정명이"abc@naver.com"이라면 읽어올 파일명은 "abc@naver.com.plist"가 되는 식
                let customPlist = "\(self.account.text!).plist" // 읽어올 파일명
                // 앱 내에 생성된 문서 디렉터리 경로를 구함
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                let path = paths[0] as NSString
                // 1과 2에서 생성된 값을 합쳐 커스텀 프로퍼티 파일을 읽어옴
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                // 읽어온 파일을 딕셔너리 객체로 변환. 만약 해당 위치에 파일이 없다면 새로운 딕셔너리 객체를 생성
                let data = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
                // 입력된 이름값을 딕셔너리 객체에 "name" 키로 저장
                data.setValue(value, forKey: "name")
                 // 딕셔너리 객체를 커스텀 프로퍼티 파일로 저장
                data.write(toFile: plist, atomically: true)
                
                /*  //이름을 입력받아 UserDefaults 객체에 저장함
                let plist = UserDefaults.standard       // 기본 저장소를 가져온다.
                plist.setValue(value, forKey: "name")   // "name"이라는 키로 값을 저장한다.
                plist.synchronize()                     // 동기화 처리
                */
                self.name.text = value
                
                // 알림창을 띄움
                self.present(alert, animated: false, completion: nil)
                
            }))
        }
        
       
        
    }
    
    
    @objc func pickerDone(_ sender: Any) {  // 사용자 계정을 변경할 때마다 실행하는 메소드
        self.view.endEditing(true)
        
        // 선택된 계정에 대한 커스텀 프로퍼티 파일을 읽어와 세팅한다.
        if let _account = self.account.text {
            let customPlist = "\(_account).plist" // 읽어올 파일명
            
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let data = NSDictionary(contentsOfFile: clist)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
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
                
                // 입력 항목을 활성화 한다.
                self.gender.isEnabled = true
                self.married.isEnabled = true
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
