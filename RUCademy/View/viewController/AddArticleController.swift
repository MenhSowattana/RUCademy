//
//  AddArticleController.swift
//  RUCademy
//
//  Created by Sowattana on 6/7/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ

class AddArticleController: BaseController {

    @IBOutlet weak var btCreate: MyButton!
    @IBOutlet weak var tfTitle: MyUITextField!
    @IBOutlet weak var tfImage: MyUITextField!
    @IBOutlet weak var tfDescription: MyUITextField!
    var viewModel: AddViewModel!
    var disposal: Disposal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }

    func setupBinding() {
        disposal = Disposal()
        viewModel = AddViewModel()
        tfTitle.rz.bind(to: viewModel.title, disPosal: disposal)
        tfImage.rz.bind(to: viewModel.image, disPosal: disposal)
        tfDescription.rz.bind(to: viewModel.description, disPosal: disposal)
    }
    
    @IBAction func create(_ sender: Any) {
        viewModel.create { [weak self] in
            guard let `self` = self else { return }
            self.alertMessage(title: "Successful", message: "Your article was published successfully.")
        }
    }
    
    func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    deinit {
        disposal.dispose()
        print("deinit controller")
    }
}
