//
//  AuthorModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/12/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import AWSCognito
import AWSCognitoIdentityProvider

class AuthorModel: NSObject {
    
    static func getAuthors(authors: @escaping ([String]) -> Void) {
        var users: [String] = []
        let request = AWSCognitoIdentityProviderListUsersInGroupRequest()
        request?.userPoolId = CognitoUserPoolId
        request?.groupName = "Admin"
        CognitoClient.getIdentityProvider().listUsers(inGroup:request!).continueWith { (task) -> Any? in
            DispatchQueue.main.async {
                guard let result = task.result, task.error == nil else {
                    print(task.error ?? "")
                    return
                }
                result.users?.forEach({ (user) in
                    users.append(user.attributes?[2].value ?? "")
                })
                authors(users)
            }
            return nil
        }
    }
    
}
