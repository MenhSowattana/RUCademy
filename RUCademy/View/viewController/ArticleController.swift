//
//  ArticleController.swift
//  RUCademy
//
//  Created by Sowattana on 6/5/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit
import ReactiveZ

struct Article {
    var id: String = ""
    var title: String = ""
    var description: String = ""
    var author: String = ""
}

class ArticleController: UIViewController {
    
    @IBOutlet weak var tbArticle: UITableView!
    @IBOutlet weak var btRefresh: MyButton!
    @IBOutlet weak var btAuthor: UIButton!
    
    var viewModel: ArticleViewModel!
    var disposal: Disposal!
    
    var articles: [AllArticlesQuery.Data.GetArticle?] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.tbArticle.reloadData()
                self.btRefresh.setLoading(loading: false)
            }
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        viewModel.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbArticle.delegate = self
        tbArticle.dataSource = self
        tbArticle.tableFooterView = UIView()
        setBidding()
        viewModel.fetchData()
    }
    
    func setBidding() {
        viewModel = ArticleViewModel()
        disposal = Disposal()
        viewModel.articles.observe { [unowned self] (datas) in
            self.articles = datas
        }
        viewModel.showLoading.observe { [unowned self] (loading) in
            self.btRefresh.setLoading(loading: loading)
        }
        btAuthor.rz.bind(to: viewModel.author, disPosal: disposal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseAuthorSegue" {
            let vc = segue.destination as! AuthorController
            vc.viewModel = viewModel
        }
    }
}

extension ArticleController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        cell.lbTitle.text = articles[indexPath.row]?.title ?? ""
        cell.lbAuthor.text = articles[indexPath.row]?.author ?? ""
        return cell
    }
    
}
