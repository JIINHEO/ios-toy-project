//
//  FormViewController.swift
//  SubmitValue-Back
//
//  Created by 허지인 on 2021/08/02.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    
    @IBAction func onSubmit(_ sender: AnyObject) {
        // slef.presentingViewController 속성은 UIViewController(부모) 타입의 인스턴스를 리턴
        // 우리가 앞서 정의해 놓은 프로퍼티는 ViewController(자식) 클래스에 정의되어 있음
        // presentingViewController 속성을 통해 이전 화면 객체를 읽어온 다음, ViewController 타입으로 캐스팅한다.
        // 전달해줄 대상 뷰 컨트롤러의 인스턴스를 찾아오는 역할
        let preVC = self.presentingViewController
        guard let vc = preVC as? ViewController else {
            return
        }
        
        // 값을 전달한다.
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
        
        NSLog("\(String(describing: self.email.text))")
        NSLog("asdfasdfasdf")
        // 이전 화면으로 복귀한다.
        
        self.presentingViewController?.dismiss(animated: true)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
