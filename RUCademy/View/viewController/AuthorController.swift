//
//  AuthorController.swift
//  RUCademy
//
//  Created by Sowattana on 6/8/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit

class AuthorController: UIViewController {

    @IBOutlet weak var tbAuthor: UITableView!
    var authors: [String] = ["Menh Sowattana", "Menh Sowattana2"]
    var previousCell: AuthorCell?
    var selectedIndex = 0
    weak var viewModel: ArticleViewModel! {
        didSet {
            selectedIndex = authors.index(of: viewModel.author.get()) ?? 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbAuthor.delegate = self
        tbAuthor.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectRow(tbAuthor, IndexPath(row: selectedIndex, section: 0))
    }
    
}

extension AuthorController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell", for: indexPath) as! AuthorCell
        cell.selectionStyle = .none
        cell.lbName.text = authors[indexPath.row]
        return cell
    }
    
    fileprivate func selectRow(_ tableView: UITableView, _ indexPath: IndexPath) {
        tableView.beginUpdates()
        if let pCell = previousCell {
            pCell.mySwitch.setOn(false, animated: true)
        }
        let cell = tableView.cellForRow(at: indexPath) as! AuthorCell
        cell.mySwitch.setOn(true, animated: true)
        tableView.endUpdates()
        previousCell = cell
        selectedIndex = indexPath.row
        viewModel.author.set(value: authors[selectedIndex])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRow(tableView, indexPath)
    }
    
}
