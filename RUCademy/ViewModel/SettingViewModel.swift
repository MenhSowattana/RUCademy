//
//  SettingViewModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/8/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ
import AWSCognitoIdentityProvider

class SettingViewModel {
    let name: ObservableField<String>!
    let email: ObservableField<String>!
    let password: ObservableField<String>!
    let errorMessage: ObservableField<String> = ObservableField("")
    let errorColor: ObservableField<UIColor> = ObservableField(.red)
    let showLoading: ObservableField<Bool> = ObservableField(false)
    var user: AWSCognitoIdentityUser = CognitoClient.getUserPool().currentUser()!
    
    init() {
        name = ObservableField(awsUser.name)
        email = ObservableField(awsUser.email)
        password = ObservableField("")
    }
    
    func update() {
        showLoading.set(value: true)
        self.errorMessage.set(value: "")
        let nameAttribute = CognitoClient.createAttribute(key: "name", value: name.get())
        user.update([nameAttribute]).continueWith { [weak self] (task) in
            guard let `self` = self else { return nil }
            
            guard let _ = task.result, task.error == nil else {
                self.errorMessage.set(value: "\(task.error?.localizedDescription ?? "")")
                self.errorColor.set(value: .red)
                return nil
            }
            //get new token
            CognitoClient.getUserPool().currentUser()?.getSession().continueOnSuccessWith(block: { (task) -> Any? in
                DispatchQueue.main.async {
                    self.showLoading.set(value: false)
                    cognitoToken = task.result?.accessToken?.tokenString ?? ""
                    self.errorMessage.set(value: "Update successfully !")
                    self.errorColor.set(value: .green)
                    awsUser.name = self.name.get()
                }
            })
            return nil
        }
    }
}

