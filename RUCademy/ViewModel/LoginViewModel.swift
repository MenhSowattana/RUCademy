//
//  LoginViewModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/7/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import AWSCognito
import AWSCognitoIdentityProvider
import ReactiveZ

class LoginViewModel {
    
    let email: ObservableField<String> = ObservableField("")
    let password: ObservableField<String> = ObservableField("")
    let errorMessage: ObservableField<String> = ObservableField("")
    let showLoading: ObservableField<Bool> = ObservableField(false)
    let presentController: ObservableField<String> = ObservableField("")
    let model = LoginModel()
    
    func login(onFailed: ((_ message: String) -> Void)? = nil) {
        showLoading.set(value: true)
        errorMessage.set(value: "")
        model.login(email: email.get(), password: password.get(), completition: { [unowned self] (group) in
            AuthorModel.getAuthors { (datas) in
                authors = datas
                let storyBoardId = group.lowercased() == "admin" ? "MainNavigator" : "MainListNavigator"
                self.presentController.set(value: storyBoardId)
                self.showLoading.set(value: false)
            }
        }) { [unowned self] (message) in
            self.showLoading.set(value: false)
            self.errorMessage.set(value: message)
            guard let `onFailed` = onFailed else { return }
            onFailed(message)
        }
    }
    
    func onRequiredChangePasswords(controller: @escaping () -> AWSCognitoIdentityNewPasswordRequired) {
        model.newPasswordController = controller
    }
    
}
