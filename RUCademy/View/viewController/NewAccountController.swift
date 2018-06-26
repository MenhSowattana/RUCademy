//
//  NewAccountController.swift
//  RUCademy
//
//  Created by Sowattana on 6/13/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ

class NewAccountController: UIViewController {
    
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var tfUsername: MyUITextField!
    @IBOutlet weak var tfEmail: MyUITextField!
    @IBOutlet weak var tfPassword: MyUITextField!
    @IBOutlet weak var btCreate: MyButton!
    let viewModel = NewAccountViewModel()
    let disposal = Disposal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfUsername.rz.bind(to: viewModel.name, disPosal: disposal)
        tfEmail.rz.bind(to: viewModel.email, disPosal: disposal)
        tfPassword.rz.bind(to: viewModel.password, disPosal: disposal)
        lbError.rz.bind(to: viewModel.errorMessage, disPosal: disposal)
        viewModel.showLoading.observe { [unowned self] (isLoading) in
            self.btCreate.setLoading(loading: isLoading)
        }
    }
    
    @IBAction func create(_ sender: Any) {
        viewModel.createAccount()
    }
    
    deinit {
        disposal.dispose()
    }
}
