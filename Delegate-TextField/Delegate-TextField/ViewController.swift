//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by 허지인 on 2021/08/04.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var tf: UITextField!
    
    @IBAction func input(_ sender: Any) {
        self.tf.becomeFirstResponder()
    }
    
    @IBAction func confirm(_ sender: Any) {
        // 텍스트 필드를 최초 응답자 객체에서 해제
        self.tf.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tf.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화
        // Do any additional setup after loading the view.
        
        // 텍스트 필드 속성 설정
        
        self.tf.borderStyle = UITextField.BorderStyle.line // 테두리 스타일 - 직선
        
        self.tf.backgroundColor = UIColor(white: 0.87, alpha: 1.0) // 배경 색상
        
        self.tf.contentVerticalAlignment = .center
        self.tf.contentHorizontalAlignment = .center
        
        self.tf.layer.borderColor = UIColor.darkGray.cgColor // 테두리 색상 회색
        
        self.tf.layer.borderWidth = 2.0 //
        
        
        self.tf.placeholder = "값을 입력하세요"
        self.tf.keyboardType = UIKeyboardType.alphabet
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark
        self.tf.returnKeyType = UIReturnKeyType.join
        
        
        self.tf.becomeFirstResponder() //텍스트 필드를 최초 응답자로 지정
        
        self.tf.delegate = self
    
    }
}

