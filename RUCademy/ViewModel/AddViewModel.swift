//
//  AddViewModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/7/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ
import AWSAppSync

class AddViewModel {
    let title: ObservableField<String> = ObservableField("")
    let image: ObservableField<String> = ObservableField("")
    let description: ObservableField<String> = ObservableField("")
    
    func create(onSuccess: @escaping () -> Void) {
        // Create a GraphQL mutation
        let uniqueId = UUID().uuidString
        let mutation = AddArticleMutation(id: uniqueId, title: title.get(), description: description.get(), author: awsUser.name)
        AppSyncClient.getInstance()?.perform(mutation: mutation, optimisticUpdate: { (transaction) in
            DispatchQueue.main.async {
                onSuccess()
            }
        }) { (result, error) in
            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
                return
            }
        }
    }
    
}
