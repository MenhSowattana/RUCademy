//
//  LoginModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/7/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import AWSCognito
import AWSCognitoIdentityProvider
import JWTDecode

class LoginModel: NSObject, AWSCognitoIdentityInteractiveAuthenticationDelegate  {
    
    var newPasswordController: (() -> AWSCognitoIdentityNewPasswordRequired)!
    
    func startNewPasswordRequired() -> AWSCognitoIdentityNewPasswordRequired {
        return newPasswordController()
    }
    
    final func login(email: String, password: String, completition: @escaping ((String) -> Void),failed: @escaping (_ message: String) -> Void) {
        
        let userPool = CognitoClient.getUser(username: email, key: "email")
        let user = userPool.user
        let pool = userPool.pool
        let attr = userPool.attribute
        pool.delegate = self
        
        // Having a user created we can now login with this credentials
        user.getSession(email, password: password, validationData: [attr]).continueWith { (task) in
            DispatchQueue.main.async {
                guard let session = task.result, task.error == nil else {
                    failed(task.error?.localizedDescription ?? "")
                    return
                }
                cognitoToken = session.accessToken?.tokenString ?? ""
                user.getDetails().continueWith { (task) in
                    guard let result = task.result, task.error == nil else {
                        print(task.error?.localizedDescription ?? "")
                        return nil
                    }
                    if let attribute = result.userAttributes {
                        DispatchQueue.main.async {
                            awsUser.name = attribute[2].value ?? ""
                            awsUser.email = attribute[3].value ?? ""
                            completition(session.groupName)
                        }
                    }
                    return nil
                }
            }
            return nil
        }
    }
}
