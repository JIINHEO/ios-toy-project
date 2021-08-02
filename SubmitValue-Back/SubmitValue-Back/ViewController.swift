//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by 허지인 on 2021/08/02.
//

import UIKit

class ViewController: UIViewController {

    // 값을 화면에 표시하기 위한 아울렛 변수들
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    // 값을 직접 전달받을 프로퍼티들
    var paramEmail: String? // 이메일 값을 전달받을 속성
    var paramUpdate: Bool? // 자동 갱신 여부를 전달받을 속성
    var paramInterval: Double? // 갱신주기 값을 전달 받을 속성
    
    // 화면이 표시될 때마다 실행되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        NSLog("viewWillAppear 실행")
        
        // nil여부를 체크하여 값이 있을 경우에는 해당하는 레이블 객체에 표시해줌
        if let email  = paramEmail {
            resultEmail.text = email
        }
        if let update = paramUpdate{
            resultUpdate.text = update==true ? "자동갱신":"자동갱신 안함"
        }
        if let interval = paramInterval {
            resultInterval.text = "\(Int(interval))분마다"
        }
    }
    
    
    override func viewDidLoad() {
        NSLog("viewDidLoad 실행")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

