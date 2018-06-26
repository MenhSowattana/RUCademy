//
//  NewAccountController.swift
//  RUCademy
//
//  Created by Sowattana on 6/13/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import AWSCognito
import AWSCognitoIdentityProvider

class NewAccountController: UIViewController {
    
    @IBOutlet weak var tfUsername: MyUITextField!
    @IBOutlet weak var tfEmail: MyUITextField!
    @IBOutlet weak var tfPassword: MyUITextField!
    @IBOutlet weak var btCreate: MyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func create(_ sender: Any) {
        let emailAttr = AWSCognitoIdentityUserAttributeType()
        emailAttr?.name = "name"
        emailAttr?.value = tfUsername.text!
        CognitoClient.getUserPool().signUp(tfEmail.text!, password: tfPassword.text!, userAttributes: [emailAttr!], validationData: nil).continueWith { (task) -> Any? in
          
                guard let session = task.result, task.error == nil else {
                    print(task.error?.localizedDescription)
                    return nil
                }
            
            let request = AWSCognitoIdentityProviderAdminAddUserToGroupRequest()
            request?.username = session.userSub
            request?.groupName = "EndUser"
            request?.userPoolId = CognitoUserPoolId
            CognitoClient.getIdentityProvider().adminAddUser(toGroup: request!).continueWith(block: { (task) -> Any? in
                guard let _ = task.result, task.error == nil else {
                    print(task.error?.localizedDescription)
                    return nil
                }
                let request = AWSCognitoIdentityProviderAdminConfirmSignUpRequest()
                request?.userPoolId = CognitoUserPoolId
                request?.username = session.user.username
                CognitoClient.getIdentityProvider().adminConfirmSignUp(request!).continueWith(block: { (task) -> Any? in
                    guard let _ = task.result, task.error == nil else {
                        print(task.error?.localizedDescription)
                        return nil
                    }
                    return nil
                })
                return nil
            })
            return nil
        }
    }
}
