//
//  ListViewController.swift
//  Chapter05-UserDafaults
//
//  Created by 장우근 on 2020/08/27.
//  Copyright © 2020 pioneerplat. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

  
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex // 0이면 남자, 1이면 여자
        
        let plist = UserDefaults.standard // 기본 저장소 객체를 가져온다.
        plist.set(value, forKey: "gender") // "gender" 라는 키로 값을 저장한다.
        plist.synchronize()
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
    }
    
    //매개변수 2개 tableview: 어느 테이블 뷰가 호출했지? , didselectRowAt indexpath: 어느 셀을 선택했지?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { // 첫 번째 셀이 클릭되었을 때
            // 입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 한다.
            let alert = UIAlertController(title: nil, message:"이름을 입력하세요", preferredStyle: UIAlertController.Style.alert)
            
            // 입력 필드 추가
            alert.addTextField() {
                $0.text = "self.name.text" // name 레이블의 텍스트를 입력폼에 기본값으로 넣어준다.
                //$0은 클로저에 대한 첫 번째 인자값, 즉 텍스트 필드 객체를 의미. 따라서 $0.text는 텍스트 필드에 입력된 텍스트 값
            }
            
            // 버튼 및 액션 추가
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_) in
                // 사용자가 OK 버튼을 누르면 입력 필드에 입력된 값을 저장한다.
            })
            // 알림창을 띄운다.
            self.present(alert, animated: false, completion: nil)
        
        }
    }
    
    
    
    
    
    // MARK: - Table view data source

    //셀의수를 리턴하는 메소드
    /* 가장 안전하고 간단한 방법은 두메소드의 override를 지워버리면 된다. 자식클래스에서 메소드가 구현되어 있지 않으면 동일한 부모 메소드가 호출되는 객체지향의 특성을 이용하는 방법이다.
     
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        //return 3 //내가 출력할 행의 수는 3개이기 때문에 0에서 3으로 수정해 준다. 표시될 행의수와 return값이 항상 일치해야 에러가 나지 않는다.
        
        return super.numberOfSections(in: tableView)//부모 메소드를 호출할 때에 입력받은 인자값을 그대로 전달한다. 전달받은 인자값을 사용하여 부모 클래스의 메소드를 호출하고, 다시 그결과값을 받아 반환한다. 이때 우리는 부모 메소드가 내부적으로 어떤 방식을 통해 테이블 뷰의 셀 개수를 구해내는지 알 필요가 없다. 단지 제대로 동작하는 부모클래스의 메소드를 호출하고 그 결과를 반환하기만 하면 된다.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
     */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
