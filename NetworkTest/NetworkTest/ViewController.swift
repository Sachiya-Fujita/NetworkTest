//
//  ViewController.swift
//  NetworkTest
//
//  Created by 1st-impact on 2019/07/08.
//  Copyright © 2019 S4ch1mos. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var introductionText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        // プロフィール取得API
        self.executeGetUserApi()
    }
    
    private func initialize() {
        [nameText, emailText, introductionText, dateText].forEach {
            $0?.text = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Network
extension ViewController {
    private func executeGetUserApi() {
        let network = NetworkLayer()
        
        network.setStartHandler {()->() in
            SVProgressHUD.show(withStatus: "Loading...")
        }
        network.setErrorHandler {(error: NSError)->() in
            // 通信失敗時
            SVProgressHUD.dismiss()
            print("通信に失敗しました")
        }
        network.setFinishHandler {(result: Any?)->() in
            // 通信成功時 (※ローディングポップアップの挙動を確認するためにワザと待たせています)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                SVProgressHUD.dismiss()
                
                guard let data = result as? UserModel else { return }
                // サーバーから取得した値を各パラメータにセットし画面へ表示
                self.nameText.text = data.name
                self.emailText.text = data.email
                self.introductionText.text = data.introduction
                self.dateText.text = data.date
            }
        }
        
        // パラメータセット
        let userId = 1
        // API実行
        network.requestApi(api: .profile(userId), parameters: nil, headers: nil)
    }


}

