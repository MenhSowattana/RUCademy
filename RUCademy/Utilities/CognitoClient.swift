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
        let pool_config = AWSCognitoIdentityUserPoolConfiguration(clientId: CognitoClientID,clientSecret: CognitoClientSecret,poolId: CognitoUserPoolId)
        AWSCognitoIdentityUserPool.register(with: aws_config,userPoolConfiguration: pool_config,forKey: "userpool")
        let awsUserPool = AWSCognitoIdentityUserPool(forKey: "userpool")
        return awsUserPool
    }
    
    
    static func getIdentityProvider() -> AWSCognitoIdentityProvider {
        let credentialProvider = AWSCognitoCredentialsProvider(regionType: .APNortheast1, identityPoolId: "ap-northeast-1:e0a728a0-1e94-4b9e-a887-8b93fce2826a")
        let configuration = AWSServiceConfiguration(region: CognitoIdentityRegion, credentialsProvider: credentialProvider)
        AWSCognitoIdentityProvider.register(with: configuration!, forKey: "provider")
        let provider = AWSCognitoIdentityProvider(forKey: "provider")
        return provider
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
