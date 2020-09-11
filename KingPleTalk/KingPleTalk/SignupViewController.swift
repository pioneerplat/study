//
//  SignupViewController.swift
//  KingPleTalk
//
//  Created by 장우근 on 2020/09/11.
//  Copyright © 2020 pioneerplat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class SignupViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    
    
    let remoteConfig = RemoteConfig.remoteConfig()
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
        signup.backgroundColor = UIColor(hex: color)
        cancel.backgroundColor = UIColor(hex: color)
        
        signup.addTarget(self, action: #selector(signinupEvent), for: UIControl.Event.touchUpInside)
        cancel.addTarget(self, action: #selector(cancelevent), for: UIControl.Event.touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    // 이 펑션을 실행시키면 앨범이 열린다.
    func imagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //회원가입
    @objc func signinupEvent() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, err) in
            let uid = user?.user.uid    // uid 는 일종의 주민등록번호
            //Database.database().reference().child("users").child(uid!).setValue(["name":self.name.text!])
            Database.database().reference().child("users").child(uid!).setValue(["name":self.name.text!])
           
        }
    }
    //이전 화면으로 돌아가는 펑션
    @objc func cancelevent() {
        self.dismiss(animated: true, completion: nil)
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
