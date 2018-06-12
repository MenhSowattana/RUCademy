//
//  NewPasswordController.swift
//  TestAppSync
//
//  Created by Sowattana on 4/18/18.
//  Copyright © 2018 RiseUp. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class NewPasswordController: UIViewController, AWSCognitoIdentityNewPasswordRequired {
    
    @IBOutlet weak var lbNewPassword: UITextField!
    var newPasswordRequiredCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityNewPasswordRequiredDetails>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changed(_ sender: Any) {
        let userDetail = AWSCognitoIdentityNewPasswordRequiredDetails(proposedPassword: lbNewPassword.text!, userAttributes: ["name": "menh sowattana"])
        self.newPasswordRequiredCompletionSource?.set(result: userDetail)
        dismiss(animated: true, completion: nil)
    }
    
    func getNewPasswordDetails(_ newPasswordRequiredInput: AWSCognitoIdentityNewPasswordRequiredInput, newPasswordRequiredCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityNewPasswordRequiredDetails>) {
        self.newPasswordRequiredCompletionSource = newPasswordRequiredCompletionSource;
    }
    
    func didCompleteNewPasswordStepWithError(_ error: Error?) {
        print(error?.localizedDescription ?? "")
    }

}
