//
//  EndUserModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/26/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import AWSCognito
import AWSCognitoIdentityProvider

class EndUserModel: NSObject {
    
    func signUp(name: String, email: String, password: String, onSuccess: @escaping () -> Void, onFailed: @escaping (_ message: String) -> Void) {
        let nameAttribute = AWSCognitoIdentityUserAttributeType()
        nameAttribute?.name = "name"
        nameAttribute?.value = name
        // Step 1: Sign up as normal user
        CognitoClient.getUserPool().signUp(email, password: password, userAttributes: [nameAttribute!], validationData: nil).continueWith { (task) -> Any? in
            
            guard let session = task.result, task.error == nil else {
                onFailed(task.error?.localizedDescription ?? "")
                return nil
            }
            // Step 2: Add registered user into group as Admin user
            let request = AWSCognitoIdentityProviderAdminAddUserToGroupRequest()
            request?.username = session.userSub
            request?.groupName = "EndUser"
            request?.userPoolId = CognitoUserPoolId
            CognitoClient.getIdentityProvider().adminAddUser(toGroup: request!).continueWith(block: { (task) -> Any? in
                guard let _ = task.result, task.error == nil else {
                    onFailed(task.error?.localizedDescription ?? "")
                    return nil
                }
                // Step 3: Confirm user as Admin user
                let request = AWSCognitoIdentityProviderAdminConfirmSignUpRequest()
                request?.userPoolId = CognitoUserPoolId
                request?.username = session.user.username
                CognitoClient.getIdentityProvider().adminConfirmSignUp(request!).continueWith(block: { (task) -> Any? in
                    guard let _ = task.result, task.error == nil else {
                        onFailed(task.error?.localizedDescription ?? "")
                        return nil
                    }
                    onSuccess()
                    return nil
                })
                return nil
            })
            return nil
        }
    }
    
}
