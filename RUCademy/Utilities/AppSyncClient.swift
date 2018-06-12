//
//  AWSClient.swift
//  TestAppSync
//
//  Created by Sowattana on 4/18/18.
//  Copyright © 2018 RiseUp. All rights reserved.
//

import UIKit
import AWSAppSync

class AppSyncClient {
    
    fileprivate static var sharedInstance: AWSAppSyncClient?
    
    static func getInstance() -> AWSAppSyncClient? {
        if sharedInstance == nil {
            do {
                guard let config = getConfig() else { return nil }
                sharedInstance = try AWSAppSyncClient(appSyncConfig: config)
                sharedInstance?.apolloClient?.cacheKeyForObject = { $0["id"] }
            } catch {
                print("Error initializing AppSync client. \(error)")
            }
        }
        return sharedInstance
    }
    
    static func getConfig() -> AWSAppSyncClientConfiguration? {
        let databaseURL = URL(fileURLWithPath:NSTemporaryDirectory()).appendingPathComponent(database_name)
        
        do {
            let config = try AWSAppSyncClientConfiguration(url: AppSyncEndpointURL, serviceRegion: AppSyncRegion, userPoolsAuthProvider: CognitoAuthProvider(),databaseURL: databaseURL)
            return config
        } catch {
            print("Error initializing AppSync client. \(error)")
        }
        return nil
    }
    
    class CognitoAuthProvider: AWSCognitoUserPoolsAuthProvider {
        func getLatestAuthToken() -> String {
            return cognitoToken
        }
    }
    
}
