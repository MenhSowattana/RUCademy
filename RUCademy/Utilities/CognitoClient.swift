//
//  CognitoClient.swift
//  RUCademy
//
//  Created by Sowattana on 6/8/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import AWSCognito
import AWSCognitoIdentityProvider
import JWTDecode

extension AWSCognitoIdentityUserSession {
    var groupName: String {
        if let token = self.idToken?.tokenString {
            if let jwt = try? decode(jwt: token) {
                let group = jwt.body["cognito:groups"]
                return (group as! NSArray)[0] as? String ?? ""
            }
        }
        return ""
    }
}

class CognitoClient {

    static func createAttribute(key: String, value: String) -> AWSCognitoIdentityUserAttributeType {
        let attribute = AWSCognitoIdentityUserAttributeType()
        attribute?.name = key
        attribute?.value = value
        return attribute!
    }
    
    static func getUserPool() -> AWSCognitoIdentityUserPool {
        let aws_config = AWSServiceConfiguration(region: CognitoIdentityRegion,credentialsProvider: nil)
        let pool_config = AWSCognitoIdentityUserPoolConfiguration(clientId: CognitoClientID,clientSecret: CognitoClientSecret,poolId: CognitoIdentityPoolId)
        AWSCognitoIdentityUserPool.register(with: aws_config,userPoolConfiguration: pool_config,forKey: "userpool")
        let awsUserPool = AWSCognitoIdentityUserPool(forKey: "userpool")
        return awsUserPool
    }
    
    static func getUser(username: String, key: String) -> (user: AWSCognitoIdentityUser, pool: AWSCognitoIdentityUserPool, attribute: AWSCognitoIdentityUserAttributeType ) {
        let awsUserPool = getUserPool()
        let emailAttr = AWSCognitoIdentityUserAttributeType()
        emailAttr?.name = key
        emailAttr?.value = username
        let user = awsUserPool.getUser(username)
        return (user,awsUserPool,emailAttr!)
    }
    
}
