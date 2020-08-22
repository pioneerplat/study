//
//  SecondViewController.swift
//  Chapter03-TabBar
//
//  Created by 장우근 on 2020/08/22.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = "두 번째 탭"
        title.textColor = UIColor.red   // 텍스트는 빨간색으로
        title.textAlignment = .center   // 레이블 내에서 중앙 정렬로
        title.font = UIFont.boldSystemFont(ofSize: 14)  // 폰트는 System Font, 14pt
        
        title.sizeToFit()   // 콘텐츠의 내용에 맞게 레이블 크기 변경
        title.center.x = self.view.frame.width / 2  // x 축의 중앙에 오도록
        
        self.view.addSubview(title)
       
    }
}
