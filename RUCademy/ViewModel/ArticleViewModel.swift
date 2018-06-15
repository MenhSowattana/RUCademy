//
//  ArticleViewModel.swift
//  RUCademy
//
//  Created by Sowattana on 6/8/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ
import AWSAppSync

class ArticleViewModel {
    
    let author = ObservableField(authors[0])
    let showLoading: ObservableField<Bool> = ObservableField(false)
    let articles: ObservableField<[AllArticlesQuery.Data.GetArticle?]> = ObservableField([])
    var authorSubscription: OnCreateArticleSubscription!
    var watcher: AWSAppSyncSubscriptionWatcher<OnCreateArticleSubscription>!
    
    init() {
        author.observe { [unowned self] (name) in 
            if self.authorSubscription == nil {
                self.authorSubscription = OnCreateArticleSubscription(author: name)
            }
            self.authorSubscription.author = name // resubcribe when author changed
            self.subscribe()
        }
    }
    
    //MARK:- Query Data from AppSync
    func fetchData() {
        showLoading.set(value: true)
        AppSyncClient.getInstance()?.fetch(query: AllArticlesQuery(), cachePolicy: .fetchIgnoringCacheData)  { [weak self] (result, error) in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.showLoading.set(value: false)
                if let articlesData = result?.data?.getArticles {
                    self.articles.set(value: articlesData.reversed())
                }
            }
        }
    }
    
    //MARK:- Subscribe to inserting record via AppSync
    func subscribe() {
        do {
            if watcher != nil {
                watcher.cancel() // Cancel previous subcription
            }
            watcher = try AppSyncClient.getInstance()?.subscribe(subscription: authorSubscription, resultHandler: { (result, transaction, error) in
                if let result = result {
                    // Store a reference to the new object
                    if let newPost = result.data!.subscribeToArticle {
                        // Create a new object for the desired query where the new object content should reside
                        let newArticle = AllArticlesQuery.Data.GetArticle(id: newPost.id,
                                                                          title: newPost.title,
                                                                          author: newPost.author,
                                                                          description: newPost.description)
                        do {
                            // Update the local store with the newly received data
                            try transaction?.update(query: AllArticlesQuery()) { (data: inout AllArticlesQuery.Data) in
                                data.getArticles?.append(newArticle)
                                self.articles.set(value: data.getArticles!.reversed())
                            }
                        } catch {
                            print("Error updating store")
                        }
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                }
            })
        } catch {
            print("Error starting subscription.")
        }
    }
    
}
