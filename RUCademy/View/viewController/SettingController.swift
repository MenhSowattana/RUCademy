//
//  SettingController.swift
//  RUCademy
//
//  Created by Sowattana on 6/8/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ

class SettingController: BaseController {

    @IBOutlet weak var tfName: MyUITextField!
    @IBOutlet weak var tfEmail: MyUITextField!
    @IBOutlet weak var tfPassword: MyUITextField!
    @IBOutlet weak var tfMessage: UILabel!
    @IBOutlet weak var btUpdate: MyButton!
    
    var viewModel: SettingViewModel!
    var disposal: Disposal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    @IBAction func update(_ sender: Any) {
        viewModel.update()
    }
    
    func setupBinding() {
        disposal = Disposal()
        viewModel = SettingViewModel()
        tfName.rz.bind(to: viewModel.name, disPosal: disposal)
        tfEmail.rz.bind(to: viewModel.email, disPosal: disposal)
        tfPassword.rz.bind(to: viewModel.password, disPosal: disposal)
        tfMessage.rz.bind(to: viewModel.errorMessage, disPosal: disposal)
        viewModel.errorColor.observe { [unowned self] (color) in
            self.tfMessage.textColor = color
        }
        viewModel.showLoading.observe { [unowned self] (loading) in
            self.btUpdate.setLoading(loading: loading)
        }
    }
    
    deinit {
        disposal.dispose()
        print("deinit controller")
    }

}
