//
//  Constants.swift
//  PostsApp
//

import Foundation
import AWSCore

let CognitoUserPoolId = "ap-northeast-1_vrYvWfedB"
let CognitoClientID = "6n57mbvi9bvph477gt7m61jv6v"
let CognitoClientSecret = "1r6u6tb5skkn2npb2qijg1sj7kpusd5t7o091n0ppp1kl5k5cb0o"
let CognitoIdentityRegion: AWSRegionType = AWSRegionType.APNortheast1


let AppSyncRegion: AWSRegionType = .APNortheast1
let AppSyncEndpointURL: URL = URL(string: "https://o4adk3yumfheji3pxhy3aleox4.appsync-api.ap-northeast-1.amazonaws.com/graphql")!
let database_name = "appsync-local-db"
var cognitoToken = ""
var authors: [String] = []
var awsUser: (name: String, email: String) = ("","")






