//
//  MenuController.swift
//  RUCademy
//
//  Created by Sowattana on 6/7/18.
//  Copyright © 2018 Sowattana. All rights reserved.
//

import UIKit

struct Menu {
    var title = ""
    var subtitle = ""
    var image = ""
}

class MenuController: UIViewController {

    @IBOutlet weak var tfName: UILabel!
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var tbMenu: UITableView!
    var menus: [Menu] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menus = [Menu(title: "New Article", subtitle: "Create new article", image: "file.png"),
                 Menu(title: "New User", subtitle: "Create new user", image: "user-2.png"),
                 Menu(title: "Profile Setting", subtitle: "Change password & information", image: "user.png")]
        tbMenu.delegate = self
        tbMenu.dataSource = self
        tbMenu.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tfName.text = awsUser.name
    }
    
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.lbTitle.text = menus[indexPath.row].title
        cell.lbSubtitle.text = menus[indexPath.row].subtitle
        cell.icon = UIImage(named: menus[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var storyboardId = ""
        switch indexPath.row {
        case 0:
            storyboardId = "NewArticleController"
            break
        case 1:
            storyboardId = "NewArticleController"
            break
        default:
            storyboardId = "SettingController"
            break
        }
        let controller = storyboard?.instantiateViewController(withIdentifier: storyboardId)
        navigationController?.pushViewController(controller!, animated: true)
    }
    
}
