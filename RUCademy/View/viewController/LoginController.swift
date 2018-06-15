//
//  ViewController.swift
//  RUCademy
//
//  Created by Sowattana on 6/5/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import JWTDecode
import ReactiveZ
import AWSCognitoIdentityProvider

class LoginController: BaseController {
    
    @IBOutlet weak var tfName: MyUITextField!
    @IBOutlet weak var tfPassword: MyUITextField!
    @IBOutlet weak var btSignin: MyButton!
    @IBOutlet weak var lbError: UILabel!
    
    var viewModel: LoginViewModel!
    var disposal: Disposal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    @IBAction func login(_ sender: Any) {
        measurePerformance {
            self.viewModel.login()
        }
    }
    
    @discardableResult
    func measurePerformance(block: @escaping () -> Void) -> Double {
        let info = ProcessInfo.processInfo
        let begin = info.systemUptime
        DispatchQueue(label: "performance").sync {
            block()
        }
        let diff = info.systemUptime - begin
        print(diff)
        return diff
    }
    
}

extension LoginController {
    
    fileprivate final func setupBinding() {
        disposal = Disposal()
        viewModel = LoginViewModel()
        viewModel.onRequiredChangePasswords { [unowned self] in
            return self.gotoNewPasswordController()
        }
        viewModel.showLoading.observe { [unowned self] (loading) in
            self.btSignin.setLoading(loading: loading)
        }
        viewModel.presentController.observe { (storyBoardId) in
            if !storyBoardId.isEmpty {
                let controller = self.storyboard?.instantiateViewController(withIdentifier: storyBoardId)
                self.present(controller!, animated: true, completion: nil)
            }
        }
        tfName.rz.bind(to: viewModel.email, disPosal: disposal)
        tfPassword.rz.bind(to: viewModel.password, disPosal: disposal)
        lbError.rz.bind(to: viewModel.errorMessage, disPosal: disposal)
    }
    
    fileprivate final func gotoNewPasswordController() -> NewPasswordController {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "NewPasswordController") as! NewPasswordController
        DispatchQueue.main.async { [unowned self] in
            self.present(controller, animated: true, completion: nil)
        }
        return controller
    }
    
}



