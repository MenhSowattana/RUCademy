//
//  NewAccountViewModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/26/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ

class NewAccountViewModel {
    
    let name = ObservableField("")
    let email = ObservableField("")
    let password = ObservableField("")
    let model = EndUserModel()
    let errorMessage: ObservableField<String> = ObservableField("")
    let showLoading: ObservableField<Bool> = ObservableField(false)
    
    func createAccount() {
        showLoading.set(value: true)
        errorMessage.set(value: "")
        model.signUp(name: name.get(), email: email.get(), password: password.get(), onSuccess: { [unowned self] in
            DispatchQueue.main.async {
                self.showLoading.set(value: false)
                self.errorMessage.set(value: "Account created successfully !")
            }
        }) { [unowned self] (message) in
            DispatchQueue.main.async {
                self.showLoading.set(value: false)
                self.errorMessage.set(value: message)
            }
        }
    }
    
}
