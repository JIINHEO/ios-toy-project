//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by 허지인 on 2021/10/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapCodePushButton(_ sender: Any) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewCotroller = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") else {return}
        self.present(viewCotroller, animated: true, completion: nil)
        viewCotroller.modalPresentationStyle = .fullScreen
        
    }
}

