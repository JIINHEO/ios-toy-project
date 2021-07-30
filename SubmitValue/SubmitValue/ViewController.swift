//
//  ViewController.swift
//  SubmitValue
//
//  Created by 허지인 on 2021/07/30.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    @IBOutlet var isUpdateText: UILabel!
    @IBOutlet var intervalText: UILabel!
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.isUpdateText.text = "갱신함"
        } else {
            self.isUpdateText.text = "갱신하지 않음"
        }
    }
    @IBAction func onStepper(_ sender: UIStepper) {
        
        let value = Int(sender.value)
        self.intervalText.text = "\(value) 분 마다"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onSubmit(_ sender: Any) {
        //VC2의 인스턴스 생성
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? ResultViewController else {
            return
        }
        
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
//        프레젠테이션 방식으로 화면 전환하면서 값을 전달하기
//        self.present(rvc, animated: true)

        
        
        // 내비게이션 컨트롤러를 통해 화면 전환하면서 값을 전달하기 
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
}

